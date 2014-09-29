require 'spec_helper'

describe "Appointments" do
  before { pending "Requests not set up" }
  describe "GET /appointments" do
    it "loads a list of appointments" do
      get appointments_path
      response.status.should be(200)
    end
  end
end
