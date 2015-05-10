class AddMinAndMaxToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :min, :date
    add_column :appointments, :max, :date
    add_index  :appointments, [:min, :max]
  end
end
