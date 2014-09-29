require 'spec_helper'

describe "AppointmentTypes" do
  before { pending "Requests not set up" }
  describe "GET /appointment_types" do
    it "lists all appointment types" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get appointment_types_path
      response.status.should be(200)
    end
  end
end
