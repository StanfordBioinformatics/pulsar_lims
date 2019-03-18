require "rails_helper"

RSpec.describe PrimersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/primers").to route_to("primers#index")
    end

    it "routes to #new" do
      expect(:get => "/primers/new").to route_to("primers#new")
    end

    it "routes to #show" do
      expect(:get => "/primers/1").to route_to("primers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/primers/1/edit").to route_to("primers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/primers").to route_to("primers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/primers/1").to route_to("primers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/primers/1").to route_to("primers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/primers/1").to route_to("primers#destroy", :id => "1")
    end

  end
end
