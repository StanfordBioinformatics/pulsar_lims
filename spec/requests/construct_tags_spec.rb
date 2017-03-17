require 'rails_helper'

RSpec.describe "ConstructTags", type: :request do
  describe "GET /construct_tags" do
    it "works! (now write some real specs)" do
      get construct_tags_path
      expect(response).to have_http_status(200)
    end
  end
end
