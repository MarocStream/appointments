require 'spec_helper'

describe "Users" do
  before { pending "Requests not set up" }
  describe "GET /admin/users" do
    it "lists users" do
      get users_path
      response.status.should be(200)
    end
  end
end
