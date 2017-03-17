require 'rails_helper'

RSpec.describe "DonorConstructs", type: :request do
  describe "GET /donor_constructs" do
    it "works! (now write some real specs)" do
      get donor_constructs_path
      expect(response).to have_http_status(200)
    end
  end
end
