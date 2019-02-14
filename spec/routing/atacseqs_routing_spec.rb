require "rails_helper"

RSpec.describe AtacseqsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/atacseqs").to route_to("atacseqs#index")
    end

    it "routes to #new" do
      expect(:get => "/atacseqs/new").to route_to("atacseqs#new")
    end

    it "routes to #show" do
      expect(:get => "/atacseqs/1").to route_to("atacseqs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/atacseqs/1/edit").to route_to("atacseqs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/atacseqs").to route_to("atacseqs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/atacseqs/1").to route_to("atacseqs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/atacseqs/1").to route_to("atacseqs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/atacseqs/1").to route_to("atacseqs#destroy", :id => "1")
    end

  end
end
