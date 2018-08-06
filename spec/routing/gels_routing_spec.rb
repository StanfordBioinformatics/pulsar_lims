require "rails_helper"

RSpec.describe GelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gels").to route_to("gels#index")
    end

    it "routes to #new" do
      expect(:get => "/gels/new").to route_to("gels#new")
    end

    it "routes to #show" do
      expect(:get => "/gels/1").to route_to("gels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gels/1/edit").to route_to("gels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gels").to route_to("gels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gels/1").to route_to("gels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gels/1").to route_to("gels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gels/1").to route_to("gels#destroy", :id => "1")
    end

  end
end
