class GroupMember < ActiveRecord::Base
  include DateParse

  self.table_name = "appointment_group_members"

  reformat_date :dob, "%m/%d/%Y"

  validates_presence_of :first, :last, :dob

  def as_json(opts)
    json = super(opts)
    json['dob'] = json['dob'].try(:strftime, "%m/%d/%Y")
    json
  end
end
