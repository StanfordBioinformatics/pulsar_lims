require "rails_helper"

RSpec.describe CrisprsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/crisprs").to route_to("crisprs#index")
    end

    it "routes to #new" do
      expect(:get => "/crisprs/new").to route_to("crisprs#new")
    end

    it "routes to #show" do
      expect(:get => "/crisprs/1").to route_to("crisprs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/crisprs/1/edit").to route_to("crisprs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/crisprs").to route_to("crisprs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/crisprs/1").to route_to("crisprs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/crisprs/1").to route_to("crisprs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/crisprs/1").to route_to("crisprs#destroy", :id => "1")
    end

  end
end
