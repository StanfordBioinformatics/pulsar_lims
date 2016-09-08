require "rails_helper"

RSpec.feature "Users can view antibodies" do

	scenario "with the :name as a link" do
		name = "howdy"
		antibody_ob = FactoryGirl.create(:antibody,name: name)
		visit antibodies_url
		click_link name
	end
end
		
