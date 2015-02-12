require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User))
    @user.stub(:patient?).and_return(true)
    view.stub(:current_user).and_return(@user)
    assign(:appointments, [stub_model(Appointment)])
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profile_path, "post" do
    end
  end
end
