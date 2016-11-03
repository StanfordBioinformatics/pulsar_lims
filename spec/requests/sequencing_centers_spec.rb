require 'rails_helper'

RSpec.describe "SequencingCenters", type: :request do
  describe "GET /sequencing_centers" do
    it "works! (now write some real specs)" do
      get sequencing_centers_path
      expect(response).to have_http_status(200)
    end
  end
end
