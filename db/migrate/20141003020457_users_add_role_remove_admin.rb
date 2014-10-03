class UsersAddRoleRemoveAdmin < ActiveRecord::Migration
  def change
    remove_column :users, :admin
    add_column :users, :role, :integer, default: 0
  end
end
