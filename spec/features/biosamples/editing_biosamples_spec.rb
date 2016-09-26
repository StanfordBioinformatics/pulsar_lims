require "rails_helper"

RSpec.feature "Users can edit biosamples" do
	let!(:documents) { [FactoryGirl.create(:document,name: "doc1"), FactoryGirl.create(:document,name: "doc2")] }
	
	before do
		FactoryGirl.create(:biosample,name: "biosample1",documents: documents)
		visit biosamples_path
		click_link "biosample1"
		click_link "Edit Biosample"
	end

	scenario "with valid attributes" do
		fill_in "Name", with: "biosample2"
		click_button "Update Biosample"
		expect(page).to have_content "Biosample was successfully updated."
		expect(page).to have_content "biosample2"
	end

	scenario "and remove documents" do
		check documents[0].name
		click_button "Update Biosample"
		expect(page).to have_content "Biosample was successfully updated."
		expect(page).to have_content "doc2"
		expect(page).to_not have_content "doc1"
	end
end
	
		
