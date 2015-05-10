require 'spec_helper'

describe "settings/index" do
  before(:each) do
    assign(:settings, [
      stub_model(Setting,
        :name => "Name",
        :desc => "Desc",
        :value => "Value"
      ),
      stub_model(Setting,
        :name => "Name",
        :desc => "Desc",
        :value => "Value"
      )
    ])
  end

  it "renders a list of settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Desc".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
