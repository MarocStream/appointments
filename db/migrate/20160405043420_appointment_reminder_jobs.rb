class AppointmentReminderJobs < ActiveRecord::Migration
  def change
    add_column :appointments, :reminder_job, :string
    add_column :appointments, :reminder_sent_at, :datetime
  end
end
