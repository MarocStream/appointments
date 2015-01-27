class User < ActiveRecord::Base
  include DateParse
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appointments
  has_many :phones
  has_many :addresses

  validates :phones, presence: true
  validates :addresses, presence: true

  enum role: {patient: 0, staff: 1, admin: 2}
  enum gender: {male: 0, female: 1}

  reformat_date :dob

  accepts_nested_attributes_for :phones, :addresses, allow_destroy: true

  scope :search, ->(q) {
    date = ['/', '-', '.'].reduce(nil) {|final,sep| final || Date.strptime(q, ['%m','%d','%Y'].join(sep)) rescue nil } || (Date.parse(q) rescue nil)
    if date
      dates = [:year, :month, :day].inject(Array.wrap(date)) {|d,t| d + [date - 1.send(t), date + 1.send(t)] }
      where(Array.new(dates.size) { "dob  = ? " }.join("OR "), *dates)
    else
      q_reg = "%#{q}%"
      joins(:phones).where("first LIKE ? OR middle LIKE ? OR last LIKE ? OR phones.number LIKE ?",
      q_reg, q_reg, q_reg, q_reg)
    end
  }

  def admin_or_staff?
    self.staff? || self.admin?
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
