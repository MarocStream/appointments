class CreateClosings < ActiveRecord::Migration
  def change
    create_table :closings do |t|
      t.datetime :date
      t.boolean :all_day
      t.string :desc

      t.timestamps
    end
  end
end
