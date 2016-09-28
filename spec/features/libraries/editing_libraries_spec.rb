require "rails_helper"

RSpec.feature "Users can edit libraries" do
	let!(:documents) { [FactoryGirl.create(:document,name: "doc1"), FactoryGirl.create(:document,name: "doc2")] }
	
	before do
		FactoryGirl.create(:library,name: "library1",documents: documents)
		visit libraries_path
		click_link "library1"
		click_link "Edit Library"
	end

	scenario "with valid attributes" do
		fill_in "Name", with: "library2"
		click_button "Update Library"
		expect(page).to have_content "Library was successfully updated."
		expect(page).to have_content "library2"
	end

	scenario "and remove documents" do
		check documents[0].name
		click_button "Update Library"
		expect(page).to have_content "Library was successfully updated."
		expect(page).to have_content "doc2"
		expect(page).to_not have_content "doc1"
	end
end
	
		
