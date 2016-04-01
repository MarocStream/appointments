class User < ActiveRecord::Base
  include DateParse
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appointments
  has_many :phones
  has_many :addresses

  validates :phones, presence: true
  validates :addresses, presence: true
  validates_presence_of :first, :last, :dob, :gender

  enum role: {patient: 0, staff: 1, admin: 2}
  enum gender: {male: 0, female: 1}

  reformat_date :dob, "%m/%d/%Y"

  accepts_nested_attributes_for :phones, :addresses, allow_destroy: true

  # Hack to stop saving '' in the email field when no email address is supplied
  before_save do |user|
    user.email = nil if user.email.blank?
  end

  scope :search, ->(q) {
    date = ['/', '-', '.'].reduce(nil) {|final,sep| final || Date.strptime(q, ['%m','%d','%Y'].join(sep)) rescue nil } || (Date.parse(q) rescue nil)
    if date
      dates = [:year, :month, :day].inject(Array.wrap(date)) {|d,t| d + [date - 1.send(t), date + 1.send(t)] }
      where(Array.new(dates.size) { "dob  = ? " }.join("OR "), *dates)
    else
      q_reg = "%#{q}%"
      joins(:phones).where("first LIKE ? OR middle LIKE ? OR last LIKE ? OR phones.number LIKE ? OR email LIKE ?",
      q_reg, q_reg, q_reg, q_reg, q_reg)
    end
  }

  def admin_or_staff?
    self.staff? || self.admin?
  end

  attr_accessor :edited_by_staff

  def timeout_in
    admin_or_staff? ? 10.years : 10.minutes
  end

  def email_required?
    !edited_by_staff
  end

  def password_required?
    !edited_by_staff
  end

  def display
    d = ""
    d += "#{first} " if first
    d += "#{middle} " if middle
    d += last || ""
    d.blank? ? "(No Name)" : d
  end

  def reverse_display
    d = ""
    d += "#{last}, " if last
    d += "#{first} " if first
    d += middle || ""
    d.blank? ? "(No Name)" : d
  end

end
