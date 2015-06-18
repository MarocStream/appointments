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
    if appointment.start
      s = appointment.start
      open = Time.parse(Setting.find_by(name: 'Open Time').try(:value) || '09:00')
      open = Time.mktime(s.year, s.month, s.day, open.hour, open.min)
      close = Time.parse(Setting.find_by(name: 'Close Time').try(:value) || '17:00')
      close = Time.mktime(s.year, s.month, s.day, close.hour, close.min)
      unless s >= open && s + (appointment_type.try(:duration) || 0).minutes <= close
        appointment.errors.add(:start, 'must be within business hours')
      end
    end
  end

  validate do |appointment|
    if appointment.start
      closings = Closing.where('date >= ? AND date <= ?', appointment.start.beginning_of_day, appointment.start.end_of_day)
      appointment_end = appointment.start + (appointment.appointment_type.try(:duration) || 0).minutes
      closings.each do |closing|
        closing_end = closing.date + closing.duration.hours
        if (appointment.start > closing.date && closing_end > appointment.start) || (appointment_end > closing.date && closing_end > appointment_end)
          appointment.errors.add(:start, "conflicts with an office closing")
        end
      end
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
