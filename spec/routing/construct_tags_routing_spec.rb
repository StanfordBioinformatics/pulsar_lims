require "rails_helper"

RSpec.describe ConstructTagsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/construct_tags").to route_to("construct_tags#index")
    end

    it "routes to #new" do
      expect(:get => "/construct_tags/new").to route_to("construct_tags#new")
    end

    it "routes to #show" do
      expect(:get => "/construct_tags/1").to route_to("construct_tags#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/construct_tags/1/edit").to route_to("construct_tags#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/construct_tags").to route_to("construct_tags#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/construct_tags/1").to route_to("construct_tags#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/construct_tags/1").to route_to("construct_tags#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/construct_tags/1").to route_to("construct_tags#destroy", :id => "1")
    end

  end
end
