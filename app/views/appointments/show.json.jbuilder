json.appointment do
  json.extract! @appointment, :id, :user_id, :start, :end_time, :appointment_type_id, :created_at, :updated_at
  json.group_members_attributes @appointment.group_members
end
