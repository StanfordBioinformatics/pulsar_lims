require "rails_helper"

RSpec.describe GenomeLocationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/genome_locations").to route_to("genome_locations#index")
    end

    it "routes to #new" do
      expect(:get => "/genome_locations/new").to route_to("genome_locations#new")
    end

    it "routes to #show" do
      expect(:get => "/genome_locations/1").to route_to("genome_locations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/genome_locations/1/edit").to route_to("genome_locations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/genome_locations").to route_to("genome_locations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/genome_locations/1").to route_to("genome_locations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/genome_locations/1").to route_to("genome_locations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/genome_locations/1").to route_to("genome_locations#destroy", :id => "1")
    end

  end
end
