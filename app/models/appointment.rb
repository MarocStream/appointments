class Appointment < ActiveRecord::Base

  # start DateTime

  belongs_to :user
  belongs_to :appointment_type

  validates_presence_of :user, :appointment_type, :start

  scope :for_user, ->(user) {
    if user && user.patient?
      where(user_id: user.id)
    elsif user && user.admin_or_staff?
      where({})
    else
      where(user_id: -1)
    end
  }

end
