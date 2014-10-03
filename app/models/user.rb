class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :appointments

  enum role: {patient: 0, staff: 1, admin: 1}

  def admin_or_staff?
    Rails.logger.error "ROLE: #{self.role}"
    self.staff? || self.admin?
  end

end
