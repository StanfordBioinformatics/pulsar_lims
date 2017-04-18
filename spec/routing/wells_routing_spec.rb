require "rails_helper"

RSpec.describe WellsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/wells").to route_to("wells#index")
    end

    it "routes to #new" do
      expect(:get => "/wells/new").to route_to("wells#new")
    end

    it "routes to #show" do
      expect(:get => "/wells/1").to route_to("wells#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/wells/1/edit").to route_to("wells#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/wells").to route_to("wells#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/wells/1").to route_to("wells#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/wells/1").to route_to("wells#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/wells/1").to route_to("wells#destroy", :id => "1")
    end

  end
end
