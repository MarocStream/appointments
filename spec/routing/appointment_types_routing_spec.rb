require "spec_helper"

describe AppointmentTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/appointment_types").should route_to("appointment_types#index")
    end

    it "routes to #new" do
      get("/admin/appointment_types/new").should route_to("appointment_types#new")
    end

    it "routes to #show" do
      get("/admin/appointment_types/1").should route_to("appointment_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/appointment_types/1/edit").should route_to("appointment_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/appointment_types").should route_to("appointment_types#create")
    end

    it "routes to #update" do
      put("/admin/appointment_types/1").should route_to("appointment_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/appointment_types/1").should route_to("appointment_types#destroy", :id => "1")
    end

  end
end
