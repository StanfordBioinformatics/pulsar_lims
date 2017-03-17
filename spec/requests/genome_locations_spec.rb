require 'rails_helper'

RSpec.describe "GenomeLocations", type: :request do
  describe "GET /genome_locations" do
    it "works! (now write some real specs)" do
      get genome_locations_path
      expect(response).to have_http_status(200)
    end
  end
end
