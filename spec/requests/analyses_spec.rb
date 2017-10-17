require 'rails_helper'

RSpec.describe "Analyses", type: :request do
  describe "GET /analyses" do
    it "works! (now write some real specs)" do
      get analyses_path
      expect(response).to have_http_status(200)
    end
  end
end
