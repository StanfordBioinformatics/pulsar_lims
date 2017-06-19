require "rails_helper"

RSpec.describe PooledLibrariesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pooled_libraries").to route_to("pooled_libraries#index")
    end

    it "routes to #new" do
      expect(:get => "/pooled_libraries/new").to route_to("pooled_libraries#new")
    end

    it "routes to #show" do
      expect(:get => "/pooled_libraries/1").to route_to("pooled_libraries#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pooled_libraries/1/edit").to route_to("pooled_libraries#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pooled_libraries").to route_to("pooled_libraries#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pooled_libraries/1").to route_to("pooled_libraries#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pooled_libraries/1").to route_to("pooled_libraries#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pooled_libraries/1").to route_to("pooled_libraries#destroy", :id => "1")
    end

  end
end
