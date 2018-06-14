require "rails_helper"

RSpec.describe BiosampleReplicatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/biosample_replicates").to route_to("biosample_replicates#index")
    end

    it "routes to #new" do
      expect(:get => "/biosample_replicates/new").to route_to("biosample_replicates#new")
    end

    it "routes to #show" do
      expect(:get => "/biosample_replicates/1").to route_to("biosample_replicates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/biosample_replicates/1/edit").to route_to("biosample_replicates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/biosample_replicates").to route_to("biosample_replicates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/biosample_replicates/1").to route_to("biosample_replicates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/biosample_replicates/1").to route_to("biosample_replicates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/biosample_replicates/1").to route_to("biosample_replicates#destroy", :id => "1")
    end

  end
end
