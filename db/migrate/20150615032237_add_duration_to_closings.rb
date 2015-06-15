class AddDurationToClosings < ActiveRecord::Migration
  def change
    add_column :closings, :duration, :int
  end
end
