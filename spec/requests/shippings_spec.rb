require 'rails_helper'

RSpec.describe "Shippings", type: :request do
  describe "GET /shippings" do
    it "works! (now write some real specs)" do
      get shippings_path
      expect(response).to have_http_status(200)
    end
  end
end
