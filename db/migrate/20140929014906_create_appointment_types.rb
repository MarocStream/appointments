class CreateAppointmentTypes < ActiveRecord::Migration
  def change
    create_table :appointment_types do |t|
      t.string :name
      t.integer :duration
      t.integer :prep_duration
      t.integer :post_duration
      t.string :color_class

      t.timestamps
    end
  end
end
