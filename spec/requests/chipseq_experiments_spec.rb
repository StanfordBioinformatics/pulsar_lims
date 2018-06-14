require 'rails_helper'

RSpec.describe "ChipseqExperiments", type: :request do
  describe "GET /chipseq_experiments" do
    it "works! (now write some real specs)" do
      get chipseq_experiments_path
      expect(response).to have_http_status(200)
    end
  end
end
