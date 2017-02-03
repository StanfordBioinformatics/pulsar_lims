require "rails_helper"

RSpec.describe SequencingResultsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sequencing_results").to route_to("sequencing_results#index")
    end

    it "routes to #new" do
      expect(:get => "/sequencing_results/new").to route_to("sequencing_results#new")
    end

    it "routes to #show" do
      expect(:get => "/sequencing_results/1").to route_to("sequencing_results#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sequencing_results/1/edit").to route_to("sequencing_results#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sequencing_results").to route_to("sequencing_results#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sequencing_results/1").to route_to("sequencing_results#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sequencing_results/1").to route_to("sequencing_results#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sequencing_results/1").to route_to("sequencing_results#destroy", :id => "1")
    end

  end
end
