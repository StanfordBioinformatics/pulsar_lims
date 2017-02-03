require 'rails_helper'

RSpec.describe "SequencingResults", type: :request do
  describe "GET /sequencing_results" do
    it "works! (now write some real specs)" do
      get sequencing_results_path
      expect(response).to have_http_status(200)
    end
  end
end
