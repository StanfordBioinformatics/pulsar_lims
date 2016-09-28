require "rails_helper"

RSpec.feature "Users can view libraries" do

	scenario "by clicking on their names" do
		library = FactoryGirl.create(:library ,name: "library az")
		visit libraries_path
		click_link "library az"
		expect(page.current_url).to eq library_url(library)
	end
end
	
		
