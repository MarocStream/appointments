class Announcement < ActiveRecord::Base
  include DateParse

  scope :recent, -> { where("end_date > ?", 1.month.ago) }
  scope :show, ->(kind) { where("end_date >= ? AND (kind = ? OR kind = ?)", Time.now, kind, Announcement.kinds[:both]) }

  reformat_date :end_date, "%m/%d/%Y %H:%M %p"

  enum :kind, {patient: 0, staff: 1, both: 2}

  validates_presence_of :name
end
