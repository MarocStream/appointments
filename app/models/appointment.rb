class Appointment < ActiveRecord::Base

  belongs_to :user
  belongs_to :appointment_type

  validates_presence_of :user, :appointment_type, :start
  validate :no_conflicts, unless: ->(app){ app.allow_conflict? }

  before_validation do
    if start && appointment_type
      self.min = start - appointment_type.prep_duration.minutes
      self.max = start + appointment_type.duration.minutes + appointment_type.post_duration.minutes
    end
  end

  validate do |appointment|
    if appointment.start < Time.parse(Setting.find_by(name: 'Open Time').value) ||
      appointment.start + appointment_type.duration.minutes > Time.parse(Setting.find_by(name: 'Close Time').value)
      appointment.errors.add(:start, 'must be within business hours')
    end
  end

  scope :for_user, ->(user) {
    if user && user.patient?
      where(user_id: user.id)
    elsif user && user.admin_or_staff?
      where({})
    else
      where(user_id: -1)
    end
  }

  scope :for_period, ->(start, duration) {
    where("start > ? AND start <= ?", start, start + duration.days)
  }

  def allow_conflict!
    @allow_conflict = true
  end
  def allow_conflict?
    @allow_conflict
  end

  def no_conflicts
    if start && Appointment.where("(min < ? AND max > ?) OR (min < ? AND max > ?)", max, max, min, min).exists?
      errors.add(:start, 'conflicts with another appointment.')
    end
  end

end
