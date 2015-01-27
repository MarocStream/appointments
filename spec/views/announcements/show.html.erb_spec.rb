require 'spec_helper'

describe "announcements/show" do
  before(:each) do
    @announcement = assign(:announcement, stub_model(Announcement,
      :name => "Name",
      :content => "Content"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Content/)
  end
end
