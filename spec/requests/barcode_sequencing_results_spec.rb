require 'rails_helper'

RSpec.describe "BarcodeSequencingResults", type: :request do
  describe "GET /barcode_sequencing_results" do
    it "works! (now write some real specs)" do
      get barcode_sequencing_results_path
      expect(response).to have_http_status(200)
    end
  end
end
