require "rails_helper"

RSpec.describe SequencingLibraryPrepKitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sequencing_library_prep_kits").to route_to("sequencing_library_prep_kits#index")
    end

    it "routes to #new" do
      expect(:get => "/sequencing_library_prep_kits/new").to route_to("sequencing_library_prep_kits#new")
    end

    it "routes to #show" do
      expect(:get => "/sequencing_library_prep_kits/1").to route_to("sequencing_library_prep_kits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sequencing_library_prep_kits/1/edit").to route_to("sequencing_library_prep_kits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sequencing_library_prep_kits").to route_to("sequencing_library_prep_kits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sequencing_library_prep_kits/1").to route_to("sequencing_library_prep_kits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sequencing_library_prep_kits/1").to route_to("sequencing_library_prep_kits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sequencing_library_prep_kits/1").to route_to("sequencing_library_prep_kits#destroy", :id => "1")
    end

  end
end
