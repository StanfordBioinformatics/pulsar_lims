require "rails_helper"

RSpec.feature "Users can view antibodies" do
	before do
		visit "/antibodies"
	end

	scenario "with the :name as a link" do
		name = "AB 1"
		antibody = FactoryGirl.create(:antibody, name: name)
		click_link name
		expect(page.current_url).to eq antibody_url(antibody)
	end
end
		
