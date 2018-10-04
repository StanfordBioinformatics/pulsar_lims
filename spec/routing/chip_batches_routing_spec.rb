require "rails_helper"

RSpec.describe ChipBatchesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/chip_batches").to route_to("chip_batches#index")
    end

    it "routes to #new" do
      expect(:get => "/chip_batches/new").to route_to("chip_batches#new")
    end

    it "routes to #show" do
      expect(:get => "/chip_batches/1").to route_to("chip_batches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/chip_batches/1/edit").to route_to("chip_batches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/chip_batches").to route_to("chip_batches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/chip_batches/1").to route_to("chip_batches#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/chip_batches/1").to route_to("chip_batches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/chip_batches/1").to route_to("chip_batches#destroy", :id => "1")
    end

  end
end
