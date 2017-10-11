require "rails_helper"

RSpec.describe FileReferencesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/file_references").to route_to("file_references#index")
    end

    it "routes to #new" do
      expect(:get => "/file_references/new").to route_to("file_references#new")
    end

    it "routes to #show" do
      expect(:get => "/file_references/1").to route_to("file_references#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/file_references/1/edit").to route_to("file_references#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/file_references").to route_to("file_references#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/file_references/1").to route_to("file_references#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/file_references/1").to route_to("file_references#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/file_references/1").to route_to("file_references#destroy", :id => "1")
    end

  end
end
