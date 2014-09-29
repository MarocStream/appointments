class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.datetime :start
      t.integer :appointment_type_id

      t.timestamps
    end
    add_index :appointments, :user_id
    add_index :appointments, :appointment_type_id
  end
end
