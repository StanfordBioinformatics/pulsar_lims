require 'rails_helper'

RSpec.describe "PooledLibraries", type: :request do
  describe "GET /pooled_libraries" do
    it "works! (now write some real specs)" do
      get pooled_libraries_path
      expect(response).to have_http_status(200)
    end
  end
end
