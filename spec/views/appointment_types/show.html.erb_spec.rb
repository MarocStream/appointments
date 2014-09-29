require 'spec_helper'

describe "appointment_types/show" do
  before(:each) do
    @appointment_type = assign(:appointment_type, stub_model(AppointmentType,
      :name => "Name",
      :duration => 1,
      :prep_duration => 2,
      :post_duration => 3,
      :color_class => "Color Class"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Color Class/)
  end
end
