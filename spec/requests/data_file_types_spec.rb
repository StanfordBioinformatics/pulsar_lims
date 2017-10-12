require 'rails_helper'

RSpec.describe "DataFileTypes", type: :request do
  describe "GET /data_file_types" do
    it "works! (now write some real specs)" do
      get data_file_types_path
      expect(response).to have_http_status(200)
    end
  end
end
