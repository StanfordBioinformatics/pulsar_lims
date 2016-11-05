require 'rails_helper'

RSpec.describe "SequencingRequests", type: :request do
  describe "GET /sequencing_requests" do
    it "works! (now write some real specs)" do
      get sequencing_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
