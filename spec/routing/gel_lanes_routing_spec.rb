require "rails_helper"

RSpec.describe GelLanesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gel_lanes").to route_to("gel_lanes#index")
    end

    it "routes to #new" do
      expect(:get => "/gel_lanes/new").to route_to("gel_lanes#new")
    end

    it "routes to #show" do
      expect(:get => "/gel_lanes/1").to route_to("gel_lanes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gel_lanes/1/edit").to route_to("gel_lanes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gel_lanes").to route_to("gel_lanes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gel_lanes/1").to route_to("gel_lanes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gel_lanes/1").to route_to("gel_lanes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gel_lanes/1").to route_to("gel_lanes#destroy", :id => "1")
    end

  end
end
