require 'spec_helper'

describe "closings/index" do
  before(:each) do
    assign(:closings, [
      stub_model(Closing,
        :all_day => false,
        :desc => "Desc"
      ),
      stub_model(Closing,
        :all_day => false,
        :desc => "Desc"
      )
    ])
  end

  it "renders a list of closings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Desc".to_s, :count => 2
  end
end
