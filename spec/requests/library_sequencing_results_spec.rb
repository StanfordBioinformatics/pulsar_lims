require 'rails_helper'

RSpec.describe "LibrarySequencingResults", type: :request do
  describe "GET /library_sequencing_results" do
    it "works! (now write some real specs)" do
      get library_sequencing_results_path
      expect(response).to have_http_status(200)
    end
  end
end
