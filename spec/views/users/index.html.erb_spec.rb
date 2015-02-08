require 'spec_helper'

describe "users/index" do
  before(:each) do
    phone = mock_model(Phone)
    assign(:users, [
      mock_model(User, phones: [phone], reverse_display: 'Last, First'),
      mock_model(User, phones: [phone], reverse_display: 'Last, First')
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
