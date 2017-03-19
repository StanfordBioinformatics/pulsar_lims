require 'rails_helper'

RSpec.describe "Crisprs", type: :request do
  describe "GET /crisprs" do
    it "works! (now write some real specs)" do
      get crisprs_path
      expect(response).to have_http_status(200)
    end
  end
end
