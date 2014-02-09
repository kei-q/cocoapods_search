require "spec_helper"

describe PodLibrariesController do
  describe "routing" do

    it "routes to #index" do
      get("/pod_libraries").should route_to("pod_libraries#index")
    end

    it "routes to #new" do
      get("/pod_libraries/new").should route_to("pod_libraries#new")
    end

    it "routes to #show" do
      get("/pod_libraries/1").should route_to("pod_libraries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pod_libraries/1/edit").should route_to("pod_libraries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pod_libraries").should route_to("pod_libraries#create")
    end

    it "routes to #update" do
      put("/pod_libraries/1").should route_to("pod_libraries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pod_libraries/1").should route_to("pod_libraries#destroy", :id => "1")
    end

  end
end
