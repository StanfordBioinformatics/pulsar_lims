require "rails_helper"

RSpec.describe GelImagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gel_images").to route_to("gel_images#index")
    end

    it "routes to #new" do
      expect(:get => "/gel_images/new").to route_to("gel_images#new")
    end

    it "routes to #show" do
      expect(:get => "/gel_images/1").to route_to("gel_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gel_images/1/edit").to route_to("gel_images#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gel_images").to route_to("gel_images#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/gel_images/1").to route_to("gel_images#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/gel_images/1").to route_to("gel_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gel_images/1").to route_to("gel_images#destroy", :id => "1")
    end

  end
end
