require 'spec_helper'

describe "closings/new" do
  before(:each) do
    assign(:closing, stub_model(Closing,
      :all_day => false,
      :desc => "MyString"
    ).as_new_record)
  end

  it "renders new closing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", closings_path, "post" do
      assert_select "input#closing_all_day[name=?]", "closing[all_day]"
      assert_select "input#closing_desc[name=?]", "closing[desc]"
    end
  end
end
