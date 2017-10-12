require "rails_helper"

RSpec.describe DataFileTypesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data_file_types").to route_to("data_file_types#index")
    end

    it "routes to #new" do
      expect(:get => "/data_file_types/new").to route_to("data_file_types#new")
    end

    it "routes to #show" do
      expect(:get => "/data_file_types/1").to route_to("data_file_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_file_types/1/edit").to route_to("data_file_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data_file_types").to route_to("data_file_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data_file_types/1").to route_to("data_file_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data_file_types/1").to route_to("data_file_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_file_types/1").to route_to("data_file_types#destroy", :id => "1")
    end

  end
end
