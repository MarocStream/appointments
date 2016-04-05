class AppointmentMailer < ActionMailer::Base

  layout 'mailer'

  def confirmation_mailer(appointment_id)
    @appointment = Appointment.find(appointment_id)
    mail(to: @appointment.user.email, subject: 'Confirmed! Washington Travel Clinic Appointment')
  end

  def reminder_mailer(appointment_id)
    @appointment = Appointment.find(appointment_id)
    unless @appointment.reminder_sent_at
      @appointment.reminder_sent_at = Time.current
      @appointment.save
      mail(to: @appointment.user.email, subject: 'Reminder: Washington Travel Clinic Appointment')
    end
  end

end
