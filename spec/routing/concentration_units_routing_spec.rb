require "rails_helper"

RSpec.describe ConcentrationUnitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/concentration_units").to route_to("concentration_units#index")
    end

    it "routes to #new" do
      expect(:get => "/concentration_units/new").to route_to("concentration_units#new")
    end

    it "routes to #show" do
      expect(:get => "/concentration_units/1").to route_to("concentration_units#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/concentration_units/1/edit").to route_to("concentration_units#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/concentration_units").to route_to("concentration_units#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/concentration_units/1").to route_to("concentration_units#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/concentration_units/1").to route_to("concentration_units#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/concentration_units/1").to route_to("concentration_units#destroy", :id => "1")
    end

  end
end
