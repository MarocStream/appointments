class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :apt
      t.string :postcode
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
