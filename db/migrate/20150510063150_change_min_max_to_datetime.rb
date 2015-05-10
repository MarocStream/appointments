class ChangeMinMaxToDatetime < ActiveRecord::Migration
  def change
    change_column :appointments, :min, :datetime
    change_column :appointments, :max, :datetime
  end
end
