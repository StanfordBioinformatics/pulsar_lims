require 'rails_helper'

RSpec.describe "Barcodes", type: :request do
  describe "GET /barcodes" do
    it "works! (now write some real specs)" do
      get barcodes_path
      expect(response).to have_http_status(200)
    end
  end
end
