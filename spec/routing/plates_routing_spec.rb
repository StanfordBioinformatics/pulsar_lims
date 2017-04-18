require "rails_helper"

RSpec.describe PlatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/plates").to route_to("plates#index")
    end

    it "routes to #new" do
      expect(:get => "/plates/new").to route_to("plates#new")
    end

    it "routes to #show" do
      expect(:get => "/plates/1").to route_to("plates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/plates/1/edit").to route_to("plates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/plates").to route_to("plates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/plates/1").to route_to("plates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/plates/1").to route_to("plates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/plates/1").to route_to("plates#destroy", :id => "1")
    end

  end
end
