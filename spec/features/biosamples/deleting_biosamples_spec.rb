require "rails_helper"

RSpec.feature "Users can delete biosamples" do

	scenario "successfully" do
		FactoryGirl.create(:biosample ,name: "biosample az")
		visit biosamples_path
		click_link "biosample az"
		click_link "Delete Biosample"
	
		expect(page).to have_content "Biosample has been deleted."	
		expect(page.current_url).to eq biosamples_url
		expect(page).to have_no_content "biosample az"
	end
end
	
		
