require "rails_helper"

RSpec.describe DataStoragesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data_storages").to route_to("data_storages#index")
    end

    it "routes to #new" do
      expect(:get => "/data_storages/new").to route_to("data_storages#new")
    end

    it "routes to #show" do
      expect(:get => "/data_storages/1").to route_to("data_storages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_storages/1/edit").to route_to("data_storages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data_storages").to route_to("data_storages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data_storages/1").to route_to("data_storages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data_storages/1").to route_to("data_storages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_storages/1").to route_to("data_storages#destroy", :id => "1")
    end

  end
end
