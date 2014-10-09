require 'spec_helper'

describe "appointments/edit" do
  before(:each) do
    @appointment = assign(:appointment, stub_model(Appointment,
      :user_id => 1,
      :appointment_type_id => 1
    ))
  end

  it "renders the edit appointment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", appointment_path(@appointment), "post" do
      assert_select "input#appointment_user_id[name=?]", "appointment[user_id]"
      assert_select "select#appointment_appointment_type_id[name=?]", "appointment[appointment_type_id]"
    end
  end
end
