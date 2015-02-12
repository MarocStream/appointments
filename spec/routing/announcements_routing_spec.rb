require "spec_helper"

describe AnnouncementsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/announcements").should route_to("announcements#index")
    end

    it "routes to #new" do
      get("/admin/announcements/new").should route_to("announcements#new")
    end

    it "routes to #show" do
      get("/admin/announcements/1").should route_to("announcements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/announcements/1/edit").should route_to("announcements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/announcements").should route_to("announcements#create")
    end

    it "routes to #update" do
      put("/admin/announcements/1").should route_to("announcements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/announcements/1").should route_to("announcements#destroy", :id => "1")
    end

  end
end
