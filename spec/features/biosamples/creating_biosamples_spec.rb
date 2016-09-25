require "rails_helper"

RSpec.feature "Users can create biosamples" do
	let!(:vendor) { FactoryGirl.create(:vendor) }
	let!(:donor)  { FactoryGirl.create(:donor) }
	let!(:biosample_type) { FactoryGirl.create(:biosample_type) }
	before do
		visit libraries_path
		click_link "New Library"
		fill_in "Name", with "example name"
		
		
	scenario "with valid attributes" do
	end
end
