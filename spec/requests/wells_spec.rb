require 'rails_helper'

RSpec.describe "Wells", type: :request do
  describe "GET /wells" do
    it "works! (now write some real specs)" do
      get wells_path
      expect(response).to have_http_status(200)
    end
  end
end
