require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/users").should route_to("users#index")
    end

    it "routes to #new" do
      get("/admin/users/new").should route_to("users#new")
    end

    it "routes to #show" do
      get("/admin/users/1").should route_to("users#show", :id => "1")
    end

    it "routes to #profile" do
      get("/users/profile").should route_to("users#profile")
    end

    it "routes to #edit" do
      get("/admin/users/1/edit").should route_to("users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/users").should_not route_to("users#create")
    end

    it "routes to #update" do
      put("/admin/users/1").should route_to("users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/users/1").should route_to("users#destroy", :id => "1")
    end

  end
end
