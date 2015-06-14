class Closing < ActiveRecord::Base

  validates_presence_of :date

  scope :for_period, ->(start, duration) {
    where("date > ? AND date <= ?", start, start + duration.days)
  }

end
