require 'spec_helper'

describe "appointment_types/index" do
  before(:each) do
    assign(:appointment_types, [
      stub_model(AppointmentType,
        :name => "Name",
        :duration => 1,
        :prep_duration => 2,
        :post_duration => 3,
        :color_class => "Color Class"
      ),
      stub_model(AppointmentType,
        :name => "Name",
        :duration => 1,
        :prep_duration => 2,
        :post_duration => 3,
        :color_class => "Color Class"
      )
    ])
  end

  it "renders a list of appointment_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Color Class".to_s, :count => 2
  end
end
