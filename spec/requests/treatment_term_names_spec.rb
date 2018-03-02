require 'rails_helper'

RSpec.describe "TreatmentTermNames", type: :request do
  describe "GET /treatment_term_names" do
    it "works! (now write some real specs)" do
      get treatment_term_names_path
      expect(response).to have_http_status(200)
    end
  end
end
