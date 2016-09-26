require "rails_helper"

RSpec.feature "Users can view biosamples" do

	scenario "by clicking on their names" do
		biosample = FactoryGirl.create(:biosample,name: "biosample1")
		visit biosamples_path
		click_link "biosample1"
		expect(page.current_url).to eq biosample_url(biosample)
	end
end
	
		
