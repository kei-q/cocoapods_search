require "spec_helper"

describe PodsController do
  describe "routing" do

    it "routes to #index" do
      get("/pods").should route_to("pods#index")
    end

    it "routes to #new" do
      get("/pods/new").should route_to("pods#new")
    end

    it "routes to #show" do
      get("/pods/1").should route_to("pods#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pods/1/edit").should route_to("pods#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pods").should route_to("pods#create")
    end

    it "routes to #update" do
      put("/pods/1").should route_to("pods#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pods/1").should route_to("pods#destroy", :id => "1")
    end

  end
end
