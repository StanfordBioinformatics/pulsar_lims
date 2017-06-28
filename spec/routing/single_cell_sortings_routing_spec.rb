require "rails_helper"

RSpec.describe SingleCellSortingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/single_cell_sortings").to route_to("single_cell_sortings#index")
    end

    it "routes to #new" do
      expect(:get => "/single_cell_sortings/new").to route_to("single_cell_sortings#new")
    end

    it "routes to #show" do
      expect(:get => "/single_cell_sortings/1").to route_to("single_cell_sortings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/single_cell_sortings/1/edit").to route_to("single_cell_sortings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/single_cell_sortings").to route_to("single_cell_sortings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/single_cell_sortings/1").to route_to("single_cell_sortings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/single_cell_sortings/1").to route_to("single_cell_sortings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/single_cell_sortings/1").to route_to("single_cell_sortings#destroy", :id => "1")
    end

  end
end
