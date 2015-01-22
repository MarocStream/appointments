class AddTypeToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :type, :integer
  end
end
