class Address < ActiveRecord::Base

  belongs_to :user

  validates :street, :postcode, :city, :state, :country, presence: true

end
