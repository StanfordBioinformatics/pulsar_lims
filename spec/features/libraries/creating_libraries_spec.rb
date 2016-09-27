require "rails_helper"

RSpec.feature "Users can create libraries " do
	let!(:user)   { FactoryGirl.create(:user) }
	let!(:vendor) { FactoryGirl.create(:vendor, name: "vendor a") }
	let!(:document) { FactoryGirl.create(:document,name: "new doc") }
	let!(:biosample) {FactoryGirl.create(:biosample,name: "example biosample") }
	let!(:antibody) {FactoryGirl.create(:antibody,name: "example antibody") }
	let!(:nucleic_acid_term) {FactoryGirl.create(:nucleic_acid_term,name: "DNA") }

	before do
		login_as(user)
		visit libraries_path
		click_link "New Library"
	end

	scenario "with valid attributes" do
		fill_in "Name", with: "example name"
		fill_in "Size range", with: "450-650"
		select "DNA", from: "library_nucleic_acid_term_id"
		select "new doc", from: "library[documents][]"
		select "vendor a", from: "library_vendor_id"
		select "example biosample", from: "library_biosample_id"
		select "example antibody", from: "library_antibody_id"
		click_button "Create Library"
		expect(page).to have_content "Library was successfully created."
		expect(page).to have_content "Created By: #{user.email}"
	end

	scenario "with invalid attributes" do
		click_button "Create Library"
		expect(page).to have_content "Name is too short"
		expect(page).to have_content "Documents can't be blank"
		expect(page).to have_content "Nucleic acid term can't be blank"
		expect(page).to have_content "Biosample can't be blank"
		#expect(page).to have_content "Antibody can't be blank"
		expect(page).to have_content "Vendor can't be blank"
		expect(page).to have_content "Size range is invalid"
	end
end
