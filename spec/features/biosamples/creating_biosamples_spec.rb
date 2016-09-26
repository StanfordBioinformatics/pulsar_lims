require "rails_helper"

RSpec.feature "Users can create biosamples" do
	let!(:vendor) { FactoryGirl.create(:vendor, name: "vendor a") }
	let!(:donor)  { FactoryGirl.create(:donor) }
	let!(:biosample_type) { FactoryGirl.create(:biosample_type) }
	let!(:document) { FactoryGirl.create(:document,name: "new doc") }

	before do
		visit biosamples_path
		click_link "New Biosample"
	end

	scenario "with valid attributes" do
		fill_in "Name", with: "example name"
		fill_in "biosample_ontology_term_accession", with: "EFO:0000962"
		select "new doc", from: "biosample[documents][]"
		select "vendor a", from: "biosample_vendor_id"
		select donor.encode_alias, from: "biosample_donor_id"
		select biosample_type.name, from: "biosample_biosample_type_id"
		click_button "Create Biosample"
		expect(page).to have_content "Biosample was successfully created."
	end

	scenario "with invalid attributes" do
		click_button "Create Biosample"
		expect(page).to have_content "Name is too short"
		expect(page).to have_content "Documents can't be blank"
		expect(page).to have_content "Biosample type can't be blank"
		expect(page).to have_content "Vendor can't be blank"
		expect(page).to have_content "Ontology term accession is invalid"
		expect(page).to have_content "Donor can't be blank"
	end
end
