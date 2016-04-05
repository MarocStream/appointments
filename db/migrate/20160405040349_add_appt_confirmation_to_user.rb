class AddApptConfirmationToUser < ActiveRecord::Migration
  def change
    add_column :users, :appointment_confirmation_email, :boolean, default: true
    add_column :users, :appointment_reminder_email, :boolean, default: true
  end
end
