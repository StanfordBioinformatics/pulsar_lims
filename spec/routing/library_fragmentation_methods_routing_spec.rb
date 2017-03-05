require "rails_helper"

RSpec.describe LibraryFragmentationMethodsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/library_fragmentation_methods").to route_to("library_fragmentation_methods#index")
    end

    it "routes to #new" do
      expect(:get => "/library_fragmentation_methods/new").to route_to("library_fragmentation_methods#new")
    end

    it "routes to #show" do
      expect(:get => "/library_fragmentation_methods/1").to route_to("library_fragmentation_methods#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/library_fragmentation_methods/1/edit").to route_to("library_fragmentation_methods#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/library_fragmentation_methods").to route_to("library_fragmentation_methods#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/library_fragmentation_methods/1").to route_to("library_fragmentation_methods#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/library_fragmentation_methods/1").to route_to("library_fragmentation_methods#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/library_fragmentation_methods/1").to route_to("library_fragmentation_methods#destroy", :id => "1")
    end

  end
end
