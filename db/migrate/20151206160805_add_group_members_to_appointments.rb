class AddGroupMembersToAppointments < ActiveRecord::Migration
  def change
    create_table :appointment_group_members do |t|
      t.string :first
      t.string :last
      t.date :dob
      t.references :appointment, index: true

      t.timestamps
    end
    remove_column :users, :family
  end
end
