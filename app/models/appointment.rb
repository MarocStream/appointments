class Appointment < ActiveRecord::Base

  belongs_to :user
  belongs_to :appointment_type
  has_many :group_members, class_name: 'GroupMember'

  accepts_nested_attributes_for :group_members, allow_destroy: true
  validates_presence_of :user, :appointment_type, :start
  validate :no_conflicts, unless: ->(app){ app.allow_conflict? }

  before_validation do
    if start && appointment_type
      self.min = start_time
      self.max = end_time
    end
  end

  validate do |appointment|
    if appointment.start && !appointment.allow_outside_business_hours?
      s = appointment.start
      open = Time.parse(Setting.find_by(name: 'Open Time').try(:value) || '09:00')
      open = Time.mktime(s.year, s.month, s.day, open.hour, open.min)
      close = Time.parse(Setting.find_by(name: 'Close Time').try(:value) || '17:00')
      close = Time.mktime(s.year, s.month, s.day, close.hour, close.min)
      unless s >= open && s + (appointment_type.try(:duration) || 0).minutes + group_time <= close
        appointment.errors.add(:start, 'must be within business hours')
      end
    end
  end

  validate do |appointment|
    if appointment.start
      closings = Closing.where('date >= ? AND date <= ? or recurring = 1', appointment.start.beginning_of_day, appointment.start.end_of_day)
      appointment_end = appointment.end_time
      closings.each do |closing|
        if closing.recurring? # Check if it is same day of the week
          if closing.date.wday == appointment.start.wday
            closing.date = closing.date.change(year: appointment.start.year, month: appointment.start.month, day: appointment.start.day)
          end
        end
        closing_end = closing.date + closing.duration.hours
        if (appointment.start > closing.date && closing_end > appointment.start) || (appointment_end > closing.date && closing_end > appointment_end)
          appointment.errors.add(:start, "conflicts with an office closing")
        end
      end
    end
  end

  after_create do
    AppointmentMailer.confirmation_mailer(self.id).deliver_later if self.user.appointment_confirmation_email
  end

  # Cancel sidekiq job if it exists
  before_save do
    if self.reminder_job
      queue = Sidekiq::Queue.new("mailer")
      queue.each do |job|
        job.delete if job.jid == self.reminder_job
      end
    end
  end

  after_save do
    if self.user.appointment_reminder_email && !@queued_job
      delivery_time = (self.start - 1.day).past? ? Time.current : self.start - 1.day
      job = AppointmentMailer.delay_until(delivery_time).reminder_mailer(self.id)
      self.reminder_job = job
      @queued_job = true
      self.save
    end
  end

  def start_time
    start - appointment_type.prep_duration.minutes
  end

  def end_time
    start + appointment_type.duration.minutes + appointment_type.post_duration.minutes + group_time.minutes
  end

  def group_time
    appointment_type.group? ? appointment_type.group_time_per_person * group_members.size : 0
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

  def allow_outside_business_hours!
    @allow_conflict = true
  end
  def allow_outside_business_hours?
    @allow_conflict
  end

  def no_conflicts
    if start && Appointment.where("(min <= ? AND max >= ?) OR (min <= ? AND max >= ?) OR (min >= ? AND max <= ?)", max, max, min, min, min, max).exists?
      errors.add(:start, 'conflicts with another appointment.')
    end
  end

end
