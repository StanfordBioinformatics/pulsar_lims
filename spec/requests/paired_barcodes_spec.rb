require 'rails_helper'

RSpec.describe "PairedBarcodes", type: :request do
  describe "GET /paired_barcodes" do
    it "works! (now write some real specs)" do
      get paired_barcodes_path
      expect(response).to have_http_status(200)
    end
  end
end
