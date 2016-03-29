class AddRecurringClosing < ActiveRecord::Migration
  def change
    add_column :closings, :recurring, :boolean
  end
end
