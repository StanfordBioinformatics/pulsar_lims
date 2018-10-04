require 'rails_helper'

RSpec.describe "ChipBatchItems", type: :request do
  describe "GET /chip_batch_items" do
    it "works! (now write some real specs)" do
      get chip_batch_items_path
      expect(response).to have_http_status(200)
    end
  end
end
