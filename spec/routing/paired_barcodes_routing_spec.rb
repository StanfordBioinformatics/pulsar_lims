require "rails_helper"

RSpec.describe PairedBarcodesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/paired_barcodes").to route_to("paired_barcodes#index")
    end

    it "routes to #new" do
      expect(:get => "/paired_barcodes/new").to route_to("paired_barcodes#new")
    end

    it "routes to #show" do
      expect(:get => "/paired_barcodes/1").to route_to("paired_barcodes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/paired_barcodes/1/edit").to route_to("paired_barcodes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/paired_barcodes").to route_to("paired_barcodes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/paired_barcodes/1").to route_to("paired_barcodes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/paired_barcodes/1").to route_to("paired_barcodes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/paired_barcodes/1").to route_to("paired_barcodes#destroy", :id => "1")
    end

  end
end
