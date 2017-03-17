require 'rails_helper'

RSpec.describe "Chromosomes", type: :request do
  describe "GET /chromosomes" do
    it "works! (now write some real specs)" do
      get chromosomes_path
      expect(response).to have_http_status(200)
    end
  end
end
