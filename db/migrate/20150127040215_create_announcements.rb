class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :name
      t.string :content
      t.datetime :end_date

      t.timestamps
    end
  end
end
