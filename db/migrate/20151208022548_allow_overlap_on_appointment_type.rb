class AllowOverlapOnAppointmentType < ActiveRecord::Migration
  def change
    add_column :appointment_types, :overlap, :boolean, default: false
  end
end
