require 'rails_helper'

RSpec.describe "FileReferences", type: :request do
  describe "GET /file_references" do
    it "works! (now write some real specs)" do
      get file_references_path
      expect(response).to have_http_status(200)
    end
  end
end
