require "rails_helper"

RSpec.describe PcrValidationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pcr_validations").to route_to("pcr_validations#index")
    end

    it "routes to #new" do
      expect(:get => "/pcr_validations/new").to route_to("pcr_validations#new")
    end

    it "routes to #show" do
      expect(:get => "/pcr_validations/1").to route_to("pcr_validations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pcr_validations/1/edit").to route_to("pcr_validations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pcr_validations").to route_to("pcr_validations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pcr_validations/1").to route_to("pcr_validations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pcr_validations/1").to route_to("pcr_validations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pcr_validations/1").to route_to("pcr_validations#destroy", :id => "1")
    end

  end
end
