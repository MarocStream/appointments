class AppointmentType < ActiveRecord::Base

  validates_presence_of :name, :duration, :color_class
  validates_uniqueness_of :color_class

  has_many :appointments

  after_initialize :defaults

  def defaults
    self.prep_duration ||= 0
    self.post_duration ||= 0
  end

end
