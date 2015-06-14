require 'spec_helper'

describe "closings/show" do
  before(:each) do
    @closing = assign(:closing, stub_model(Closing,
      :all_day => false,
      :desc => "Desc"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(/Desc/)
  end
end
