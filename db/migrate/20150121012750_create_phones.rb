class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :user_id
      t.integer :number
      t.integer :country

      t.timestamps
    end
  end
end
