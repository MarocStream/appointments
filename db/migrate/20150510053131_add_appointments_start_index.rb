class AddAppointmentsStartIndex < ActiveRecord::Migration
  def change
    change_table :appointments do |t|
      t.index :start
    end
  end
end
