require 'rails_helper'

RSpec.describe "BiosampleTermNames", type: :request do
  describe "GET /biosample_term_names" do
    it "works! (now write some real specs)" do
      get biosample_term_names_path
      expect(response).to have_http_status(200)
    end
  end
end
