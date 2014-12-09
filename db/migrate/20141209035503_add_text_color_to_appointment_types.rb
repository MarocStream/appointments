class AddTextColorToAppointmentTypes < ActiveRecord::Migration
  def change
    add_column :appointment_types, :text_color, :string
  end
end
