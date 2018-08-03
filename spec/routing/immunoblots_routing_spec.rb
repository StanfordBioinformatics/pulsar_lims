require "rails_helper"

RSpec.describe ImmunoblotsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/immunoblots").to route_to("immunoblots#index")
    end

    it "routes to #new" do
      expect(:get => "/immunoblots/new").to route_to("immunoblots#new")
    end

    it "routes to #show" do
      expect(:get => "/immunoblots/1").to route_to("immunoblots#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/immunoblots/1/edit").to route_to("immunoblots#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/immunoblots").to route_to("immunoblots#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/immunoblots/1").to route_to("immunoblots#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/immunoblots/1").to route_to("immunoblots#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/immunoblots/1").to route_to("immunoblots#destroy", :id => "1")
    end

  end
end
