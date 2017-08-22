require 'rails_helper'

RSpec.describe "ConcentrationUnits", type: :request do
  describe "GET /concentration_units" do
    it "works! (now write some real specs)" do
      get concentration_units_path
      expect(response).to have_http_status(200)
    end
  end
end
