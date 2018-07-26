require 'rails_helper'

RSpec.describe "GelLanes", type: :request do
  describe "GET /gel_lanes" do
    it "works! (now write some real specs)" do
      get gel_lanes_path
      expect(response).to have_http_status(200)
    end
  end
end
