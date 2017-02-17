require 'rails_helper'

RSpec.describe "CrisprGeneticModifications", type: :request do
  describe "GET /crispr_genetic_modifications" do
    it "works! (now write some real specs)" do
      get crispr_genetic_modifications_path
      expect(response).to have_http_status(200)
    end
  end
end
