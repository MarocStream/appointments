class AddKindToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :kind, :integer
  end
end
