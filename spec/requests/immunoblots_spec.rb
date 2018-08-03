require 'rails_helper'

RSpec.describe "Immunoblots", type: :request do
  describe "GET /immunoblots" do
    it "works! (now write some real specs)" do
      get immunoblots_path
      expect(response).to have_http_status(200)
    end
  end
end
