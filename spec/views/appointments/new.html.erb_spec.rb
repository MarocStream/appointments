require 'spec_helper'

describe "appointments/new" do
  before(:each) do
    assign(:appointment, stub_model(Appointment,
      :user_id => 1,
      :appointment_type_id => 1
    ).as_new_record)
  end

  it "renders new appointment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", appointments_path, "post" do
      assert_select "input#appointment_user_id[name=?]", "appointment[user_id]"
      assert_select "select#appointment_appointment_type_id[name=?]", "appointment[appointment_type_id]"
    end
  end
end
