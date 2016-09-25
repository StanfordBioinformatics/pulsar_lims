require "rails_helper"

RSpec.feature "Users can create donors" do
	before do
		visit donors_path
		click_link "New Donor"
	end

	scenario "with valid attributes" do
		fill_in "donor_encode_identifier", with: "ENCDO000AAC"
		click_button "Create Donor"
	end
end
