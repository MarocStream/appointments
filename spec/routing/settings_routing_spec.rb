require "spec_helper"

describe SettingsController do
  describe "routing" do

    it "routes to #index" do
      get("/settings").should route_to("settings#index")
    end

    it "routes to #new" do
      get("/admin/settings/new").should route_to("settings#new")
    end

    it "routes to #show" do
      get("/admin/settings/1").should route_to("settings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/settings/1/edit").should route_to("settings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/settings").should route_to("settings#create")
    end

    it "routes to #update" do
      put("/admin/settings/1").should route_to("settings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/settings/1").should route_to("settings#destroy", :id => "1")
    end

  end
end
