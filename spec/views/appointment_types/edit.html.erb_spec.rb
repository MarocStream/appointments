require 'spec_helper'

describe "appointment_types/edit" do
  before(:each) do
    @appointment_type = assign(:appointment_type, stub_model(AppointmentType,
      :name => "MyString",
      :duration => 1,
      :prep_duration => 1,
      :post_duration => 1,
      :color_class => "MyString"
    ))
  end

  it "renders the edit appointment_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_appointment_type_path(@appointment_type), "post" do
      assert_select "input#appointment_type_name[name=?]", "appointment_type[name]"
      assert_select "input#appointment_type_duration[name=?]", "appointment_type[duration]"
      assert_select "input#appointment_type_prep_duration[name=?]", "appointment_type[prep_duration]"
      assert_select "input#appointment_type_post_duration[name=?]", "appointment_type[post_duration]"
      assert_select "select#appointment_type_color_class[name=?]", "appointment_type[color_class]"
    end
  end
end
