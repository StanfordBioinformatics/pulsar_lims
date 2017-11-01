require 'rails_helper'

RSpec.describe "PcrValidations", type: :request do
  describe "GET /pcr_validations" do
    it "works! (now write some real specs)" do
      get pcr_validations_path
      expect(response).to have_http_status(200)
    end
  end
end
