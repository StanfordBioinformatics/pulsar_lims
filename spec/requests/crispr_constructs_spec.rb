require 'rails_helper'

RSpec.describe "CrisprConstructs", type: :request do
  describe "GET /crispr_constructs" do
    it "works! (now write some real specs)" do
      get crispr_constructs_path
      expect(response).to have_http_status(200)
    end
  end
end
