require 'rails_helper'

RSpec.describe "LibraryFragmentationMethods", type: :request do
  describe "GET /library_fragmentation_methods" do
    it "works! (now write some real specs)" do
      get library_fragmentation_methods_path
      expect(response).to have_http_status(200)
    end
  end
end
