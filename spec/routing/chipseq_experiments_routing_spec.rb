require "rails_helper"

RSpec.describe ChipseqExperimentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/chipseq_experiments").to route_to("chipseq_experiments#index")
    end

    it "routes to #new" do
      expect(:get => "/chipseq_experiments/new").to route_to("chipseq_experiments#new")
    end

    it "routes to #show" do
      expect(:get => "/chipseq_experiments/1").to route_to("chipseq_experiments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/chipseq_experiments/1/edit").to route_to("chipseq_experiments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/chipseq_experiments").to route_to("chipseq_experiments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/chipseq_experiments/1").to route_to("chipseq_experiments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/chipseq_experiments/1").to route_to("chipseq_experiments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/chipseq_experiments/1").to route_to("chipseq_experiments#destroy", :id => "1")
    end

  end
end
