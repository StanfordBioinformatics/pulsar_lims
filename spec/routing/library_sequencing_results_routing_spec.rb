require "rails_helper"

RSpec.describe LibrarySequencingResultsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/library_sequencing_results").to route_to("library_sequencing_results#index")
    end

    it "routes to #new" do
      expect(:get => "/library_sequencing_results/new").to route_to("library_sequencing_results#new")
    end

    it "routes to #show" do
      expect(:get => "/library_sequencing_results/1").to route_to("library_sequencing_results#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/library_sequencing_results/1/edit").to route_to("library_sequencing_results#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/library_sequencing_results").to route_to("library_sequencing_results#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/library_sequencing_results/1").to route_to("library_sequencing_results#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/library_sequencing_results/1").to route_to("library_sequencing_results#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/library_sequencing_results/1").to route_to("library_sequencing_results#destroy", :id => "1")
    end

  end
end
