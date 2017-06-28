require 'rails_helper'

RSpec.describe "SingleCellSortings", type: :request do
  describe "GET /single_cell_sortings" do
    it "works! (now write some real specs)" do
      get single_cell_sortings_path
      expect(response).to have_http_status(200)
    end
  end
end
