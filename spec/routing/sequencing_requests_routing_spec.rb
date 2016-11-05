require "rails_helper"

RSpec.describe SequencingRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sequencing_requests").to route_to("sequencing_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/sequencing_requests/new").to route_to("sequencing_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/sequencing_requests/1").to route_to("sequencing_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sequencing_requests/1/edit").to route_to("sequencing_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sequencing_requests").to route_to("sequencing_requests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sequencing_requests/1").to route_to("sequencing_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sequencing_requests/1").to route_to("sequencing_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sequencing_requests/1").to route_to("sequencing_requests#destroy", :id => "1")
    end

  end
end
