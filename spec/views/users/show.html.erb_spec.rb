require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User))
    @user.stub(:patient?).and_return(true)
    view.stub(:current_user).and_return(@user)
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
