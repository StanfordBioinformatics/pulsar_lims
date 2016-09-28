require "rails_helper"

RSpec.feature "Users can delete libraries" do

	scenario "successfully" do
		FactoryGirl.create(:library ,name: "library az")
		visit libraries_path
		click_link "library az"
		click_link "Delete Library"
	
		expect(page).to have_content "Library has been deleted."	
		expect(page.current_url).to eq libraries_url
		expect(page).to have_no_content "library az"
	end
end
	
		
