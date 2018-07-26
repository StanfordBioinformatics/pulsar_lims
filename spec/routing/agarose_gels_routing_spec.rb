require "rails_helper"

RSpec.describe AgaroseGelsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/agarose_gels").to route_to("agarose_gels#index")
    end

    it "routes to #new" do
      expect(:get => "/agarose_gels/new").to route_to("agarose_gels#new")
    end

    it "routes to #show" do
      expect(:get => "/agarose_gels/1").to route_to("agarose_gels#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/agarose_gels/1/edit").to route_to("agarose_gels#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/agarose_gels").to route_to("agarose_gels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/agarose_gels/1").to route_to("agarose_gels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/agarose_gels/1").to route_to("agarose_gels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/agarose_gels/1").to route_to("agarose_gels#destroy", :id => "1")
    end

  end
end
