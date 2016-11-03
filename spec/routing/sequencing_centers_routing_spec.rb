require "rails_helper"

RSpec.describe SequencingCentersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sequencing_centers").to route_to("sequencing_centers#index")
    end

    it "routes to #new" do
      expect(:get => "/sequencing_centers/new").to route_to("sequencing_centers#new")
    end

    it "routes to #show" do
      expect(:get => "/sequencing_centers/1").to route_to("sequencing_centers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sequencing_centers/1/edit").to route_to("sequencing_centers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sequencing_centers").to route_to("sequencing_centers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sequencing_centers/1").to route_to("sequencing_centers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sequencing_centers/1").to route_to("sequencing_centers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sequencing_centers/1").to route_to("sequencing_centers#destroy", :id => "1")
    end

  end
end
