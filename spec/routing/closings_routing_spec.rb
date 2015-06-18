require "spec_helper"

describe ClosingsController do
  describe "routing" do

    it "routes to #create" do
      post("/admin/closings").should route_to("closings#create")
    end

    it "routes to #update" do
      put("/admin/closings/1").should route_to("closings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/closings/1").should route_to("closings#destroy", :id => "1")
    end

  end
end
