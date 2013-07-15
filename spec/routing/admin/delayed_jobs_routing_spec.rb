require "spec_helper"

describe Admin::DelayedJobsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/delayed_jobs").should route_to("admin/delayed_jobs#index")
    end

    it "routes to #new" do
      get("/admin/delayed_jobs/new").should route_to("admin/delayed_jobs#new")
    end

    it "routes to #show" do
      get("/admin/delayed_jobs/1").should route_to("admin/delayed_jobs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/delayed_jobs/1/edit").should route_to("admin/delayed_jobs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/delayed_jobs").should route_to("admin/delayed_jobs#create")
    end

    it "routes to #update" do
      put("/admin/delayed_jobs/1").should route_to("admin/delayed_jobs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/delayed_jobs/1").should route_to("admin/delayed_jobs#destroy", :id => "1")
    end

  end
end
