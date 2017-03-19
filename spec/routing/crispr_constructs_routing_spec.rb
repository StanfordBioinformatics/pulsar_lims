require "rails_helper"

RSpec.describe CrisprConstructsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/crispr_constructs").to route_to("crispr_constructs#index")
    end

    it "routes to #new" do
      expect(:get => "/crispr_constructs/new").to route_to("crispr_constructs#new")
    end

    it "routes to #show" do
      expect(:get => "/crispr_constructs/1").to route_to("crispr_constructs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/crispr_constructs/1/edit").to route_to("crispr_constructs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/crispr_constructs").to route_to("crispr_constructs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/crispr_constructs/1").to route_to("crispr_constructs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/crispr_constructs/1").to route_to("crispr_constructs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/crispr_constructs/1").to route_to("crispr_constructs#destroy", :id => "1")
    end

  end
end
