require "rails_helper"

RSpec.feature "Admins can create new users" do
	let(:admin) { FactoryGirl.create(:user, :admin) }

	before do
		login_as(admin)
		visit "/"
		click_link "Admin"
		click_link "Users"
		click_link "New User"
	end

	scenario "with valid credentials" do
		fill_in "Email", with: "Bob@example.com"
		fill_in "Password", with: "password"
		click_button "Create User"
		expect(page).to have_content "User was successfully created."
	end

	scenario "when the new user is an admin" do
		fill_in "Email", with: "admin@example.com"
		fill_in "Password", with: "password"
		check "Set Admin"
		click_button "Create User"
		expect(page).to have_content "User was successfully created."
	end
end
