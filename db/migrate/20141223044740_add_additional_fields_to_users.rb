class AddAdditionalFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dob, :date
    add_column :users, :gender, :integer
    add_column :users, :business, :string
  end
end
