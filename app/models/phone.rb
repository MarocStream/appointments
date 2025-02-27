class Phone < ActiveRecord::Base

  belongs_to :user

  enum :kind, {daytime: 0, evening: 1, cell: 2}

  validates :kind, :number, presence: true

end
