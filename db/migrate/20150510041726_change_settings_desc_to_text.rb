class ChangeSettingsDescToText < ActiveRecord::Migration
  def up
    change_column :settings, :desc, :text
  end
  def down
    change_column :settings, :desc, :string
  end
end
