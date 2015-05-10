require 'spec_helper'

describe "settings/new" do
  before(:each) do
    assign(:setting, stub_model(Setting,
      :name => "MyString",
      :desc => "MyString",
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_settings_path, "post" do
      assert_select "input#setting_name[name=?]", "setting[name]"
      assert_select "textarea#setting_desc[name=?]", "setting[desc]"
      assert_select "input#setting_value[name=?]", "setting[value]"
    end
  end
end
