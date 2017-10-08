require 'rails_helper'

RSpec.describe "DataStorageProviders", type: :request do
  describe "GET /data_storage_providers" do
    it "works! (now write some real specs)" do
      get data_storage_providers_path
      expect(response).to have_http_status(200)
    end
  end
end
