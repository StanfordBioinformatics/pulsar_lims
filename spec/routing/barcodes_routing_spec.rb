require "rails_helper"

RSpec.describe BarcodesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/barcodes").to route_to("barcodes#index")
    end

    it "routes to #new" do
      expect(:get => "/barcodes/new").to route_to("barcodes#new")
    end

    it "routes to #show" do
      expect(:get => "/barcodes/1").to route_to("barcodes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/barcodes/1/edit").to route_to("barcodes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/barcodes").to route_to("barcodes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/barcodes/1").to route_to("barcodes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/barcodes/1").to route_to("barcodes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/barcodes/1").to route_to("barcodes#destroy", :id => "1")
    end

  end
end
