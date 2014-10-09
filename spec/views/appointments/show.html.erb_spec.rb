require 'spec_helper'

describe "appointments/show" do
  before(:each) do
    @appointment = assign(:appointment, stub_model(Appointment,
      :user => stub_model(User, display: "USER"),
      :appointment_type => stub_model(AppointmentType, name: "TYPE")
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/USER/)
    rendered.should match(/TYPE/)
  end
end
