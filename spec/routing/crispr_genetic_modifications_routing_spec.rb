require "rails_helper"

RSpec.describe CrisprGeneticModificationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/crispr_genetic_modifications").to route_to("crispr_genetic_modifications#index")
    end

    it "routes to #new" do
      expect(:get => "/crispr_genetic_modifications/new").to route_to("crispr_genetic_modifications#new")
    end

    it "routes to #show" do
      expect(:get => "/crispr_genetic_modifications/1").to route_to("crispr_genetic_modifications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/crispr_genetic_modifications/1/edit").to route_to("crispr_genetic_modifications#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/crispr_genetic_modifications").to route_to("crispr_genetic_modifications#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/crispr_genetic_modifications/1").to route_to("crispr_genetic_modifications#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/crispr_genetic_modifications/1").to route_to("crispr_genetic_modifications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/crispr_genetic_modifications/1").to route_to("crispr_genetic_modifications#destroy", :id => "1")
    end

  end
end
