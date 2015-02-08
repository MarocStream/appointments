require 'spec_helper'

describe "announcements/index" do
  before(:each) do
    assign(:announcements, [
      mock_model(Announcement,
        name: "Name",
        content: "Content",
        end_date: 2.days.from_now.to_datetime,
        staff?: true
      ),
      mock_model(Announcement,
        name: "Name",
        content: "Content",
        end_date: 2.days.from_now.to_datetime,
        staff?: false
      )
    ])
  end

  it "renders a list of announcements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
