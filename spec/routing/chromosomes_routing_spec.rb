require "rails_helper"

RSpec.describe ChromosomesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/chromosomes").to route_to("chromosomes#index")
    end

    it "routes to #new" do
      expect(:get => "/chromosomes/new").to route_to("chromosomes#new")
    end

    it "routes to #show" do
      expect(:get => "/chromosomes/1").to route_to("chromosomes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/chromosomes/1/edit").to route_to("chromosomes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/chromosomes").to route_to("chromosomes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/chromosomes/1").to route_to("chromosomes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/chromosomes/1").to route_to("chromosomes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/chromosomes/1").to route_to("chromosomes#destroy", :id => "1")
    end

  end
end
