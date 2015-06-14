require "spec_helper"

describe ClosingsController do
  describe "routing" do

    it "routes to #index" do
      get("/closings").should route_to("closings#index")
    end

    it "routes to #new" do
      get("/closings/new").should route_to("closings#new")
    end

    it "routes to #show" do
      get("/closings/1").should route_to("closings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/closings/1/edit").should route_to("closings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/closings").should route_to("closings#create")
    end

    it "routes to #update" do
      put("/closings/1").should route_to("closings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/closings/1").should route_to("closings#destroy", :id => "1")
    end

  end
end
