require 'rails_helper'

RSpec.describe "SequencingLibraryPrepKits", type: :request do
  describe "GET /sequencing_library_prep_kits" do
    it "works! (now write some real specs)" do
      get sequencing_library_prep_kits_path
      expect(response).to have_http_status(200)
    end
  end
end
