class AddDescriptionToAppointmentType < ActiveRecord::Migration
  def change
    add_column :appointment_types, :description, :text
  end
end
