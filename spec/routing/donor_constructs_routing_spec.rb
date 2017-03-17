require "rails_helper"

RSpec.describe DonorConstructsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/donor_constructs").to route_to("donor_constructs#index")
    end

    it "routes to #new" do
      expect(:get => "/donor_constructs/new").to route_to("donor_constructs#new")
    end

    it "routes to #show" do
      expect(:get => "/donor_constructs/1").to route_to("donor_constructs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/donor_constructs/1/edit").to route_to("donor_constructs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/donor_constructs").to route_to("donor_constructs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/donor_constructs/1").to route_to("donor_constructs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/donor_constructs/1").to route_to("donor_constructs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/donor_constructs/1").to route_to("donor_constructs#destroy", :id => "1")
    end

  end
end
