require 'rails_helper'

RSpec.describe "AgaroseGels", type: :request do
  describe "GET /agarose_gels" do
    it "works! (now write some real specs)" do
      get agarose_gels_path
      expect(response).to have_http_status(200)
    end
  end
end
