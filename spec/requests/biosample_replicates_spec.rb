require 'rails_helper'

RSpec.describe "BiosampleReplicates", type: :request do
  describe "GET /biosample_replicates" do
    it "works! (now write some real specs)" do
      get biosample_replicates_path
      expect(response).to have_http_status(200)
    end
  end
end
