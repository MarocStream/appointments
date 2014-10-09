require 'spec_helper'

describe "appointments/index" do
  before(:each) do
    assign(:appointments, [
      stub_model(Appointment,
        :user => stub_model(User, display: "USER"),
        :appointment_type => stub_model(AppointmentType, name: "TYPE"),
        :start => 1.day.ago
      ),
      stub_model(Appointment,
        :user => stub_model(User, display: "USER"),
        :appointment_type => stub_model(AppointmentType, name: "TYPE"),
        :start => 2.days.ago
      )
    ])
  end

  it "renders a list of appointments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "USER", :count => 2
    assert_select "tr>td", :text => "TYPE", :count => 2
  end
end
