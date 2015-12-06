class AddGroupToAppointmentType < ActiveRecord::Migration
  def change
    add_column :appointment_types, :group, :boolean, default: false
    add_column :appointment_types, :group_time_per_person, :integer, default: 10
  end
end
