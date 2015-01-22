class Phone < ActiveRecord::Base

  belongs_to :user

  enum kind: {home: 0, work: 1, cell: 2}

end
