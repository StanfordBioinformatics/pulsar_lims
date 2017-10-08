require "rails_helper"

RSpec.describe DataStorageProvidersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data_storage_providers").to route_to("data_storage_providers#index")
    end

    it "routes to #new" do
      expect(:get => "/data_storage_providers/new").to route_to("data_storage_providers#new")
    end

    it "routes to #show" do
      expect(:get => "/data_storage_providers/1").to route_to("data_storage_providers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_storage_providers/1/edit").to route_to("data_storage_providers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data_storage_providers").to route_to("data_storage_providers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data_storage_providers/1").to route_to("data_storage_providers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data_storage_providers/1").to route_to("data_storage_providers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_storage_providers/1").to route_to("data_storage_providers#destroy", :id => "1")
    end

  end
end
