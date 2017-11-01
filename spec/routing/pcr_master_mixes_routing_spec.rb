require "rails_helper"

RSpec.describe PcrMasterMixesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/pcr_master_mixes").to route_to("pcr_master_mixes#index")
    end

    it "routes to #new" do
      expect(:get => "/pcr_master_mixes/new").to route_to("pcr_master_mixes#new")
    end

    it "routes to #show" do
      expect(:get => "/pcr_master_mixes/1").to route_to("pcr_master_mixes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/pcr_master_mixes/1/edit").to route_to("pcr_master_mixes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/pcr_master_mixes").to route_to("pcr_master_mixes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/pcr_master_mixes/1").to route_to("pcr_master_mixes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/pcr_master_mixes/1").to route_to("pcr_master_mixes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/pcr_master_mixes/1").to route_to("pcr_master_mixes#destroy", :id => "1")
    end

  end
end
