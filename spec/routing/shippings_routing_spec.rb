require "rails_helper"

RSpec.describe ShippingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shippings").to route_to("shippings#index")
    end

    it "routes to #new" do
      expect(:get => "/shippings/new").to route_to("shippings#new")
    end

    it "routes to #show" do
      expect(:get => "/shippings/1").to route_to("shippings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shippings/1/edit").to route_to("shippings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shippings").to route_to("shippings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shippings/1").to route_to("shippings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shippings/1").to route_to("shippings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shippings/1").to route_to("shippings#destroy", :id => "1")
    end

  end
end
