require "rails_helper"

RSpec.describe ChipBatchItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/chip_batch_items").to route_to("chip_batch_items#index")
    end

    it "routes to #new" do
      expect(:get => "/chip_batch_items/new").to route_to("chip_batch_items#new")
    end

    it "routes to #show" do
      expect(:get => "/chip_batch_items/1").to route_to("chip_batch_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/chip_batch_items/1/edit").to route_to("chip_batch_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/chip_batch_items").to route_to("chip_batch_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/chip_batch_items/1").to route_to("chip_batch_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/chip_batch_items/1").to route_to("chip_batch_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/chip_batch_items/1").to route_to("chip_batch_items#destroy", :id => "1")
    end

  end
end
