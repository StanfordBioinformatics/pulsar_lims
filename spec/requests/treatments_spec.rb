require 'rails_helper'

RSpec.describe "Treatments", type: :request do
  describe "GET /treatments" do
    it "works! (now write some real specs)" do
      get treatments_path
      expect(response).to have_http_status(200)
    end
  end
end
