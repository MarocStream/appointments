require 'spec_helper'

describe "closings/edit" do
  before(:each) do
    @closing = assign(:closing, stub_model(Closing,
      :all_day => false,
      :desc => "MyString"
    ))
  end

  it "renders the edit closing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", closing_path(@closing), "post" do
      assert_select "input#closing_all_day[name=?]", "closing[all_day]"
      assert_select "input#closing_desc[name=?]", "closing[desc]"
    end
  end
end
