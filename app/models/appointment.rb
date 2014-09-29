class Appointment < ActiveRecord::Base

  # start DateTime

  belongs_to :user
  belongs_to :appointment_type

  validates_presence_of :user, :appointment_type, :start

end
