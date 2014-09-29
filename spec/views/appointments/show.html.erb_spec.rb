require 'spec_helper'

describe "appointments/show" do
  before(:each) do
    @appointment = assign(:appointment, stub_model(Appointment,
      :user_id => 1,
      :appointment_type_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
