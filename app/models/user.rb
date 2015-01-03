class User < ActiveRecord::Base
  include DateParse
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appointments

  enum role: {patient: 0, staff: 1, admin: 2}
  enum gender: {male: 0, female: 1}

  reformat_date :dob

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
