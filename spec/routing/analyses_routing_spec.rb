require "rails_helper"

RSpec.describe AnalysesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/analyses").to route_to("analyses#index")
    end

    it "routes to #new" do
      expect(:get => "/analyses/new").to route_to("analyses#new")
    end

    it "routes to #show" do
      expect(:get => "/analyses/1").to route_to("analyses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/analyses/1/edit").to route_to("analyses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/analyses").to route_to("analyses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/analyses/1").to route_to("analyses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/analyses/1").to route_to("analyses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/analyses/1").to route_to("analyses#destroy", :id => "1")
    end

  end
end
