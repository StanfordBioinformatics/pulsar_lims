require "rails_helper"

RSpec.describe BiosampleTermNamesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/biosample_term_names").to route_to("biosample_term_names#index")
    end

    it "routes to #new" do
      expect(:get => "/biosample_term_names/new").to route_to("biosample_term_names#new")
    end

    it "routes to #show" do
      expect(:get => "/biosample_term_names/1").to route_to("biosample_term_names#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/biosample_term_names/1/edit").to route_to("biosample_term_names#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/biosample_term_names").to route_to("biosample_term_names#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/biosample_term_names/1").to route_to("biosample_term_names#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/biosample_term_names/1").to route_to("biosample_term_names#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/biosample_term_names/1").to route_to("biosample_term_names#destroy", :id => "1")
    end

  end
end
