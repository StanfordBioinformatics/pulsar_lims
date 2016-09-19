require "rails_helper"

RSpec.feature "Users can create an account" do
	scenario "when providing valid information" do
		visit "/"
		click_link "Create Account"
		fill_in "Email", with: "testemail@bob.com"
		fill_in "user_password", with: "password12345"
		fill_in"user_password_confirmation", with: "password12345"
		click_button "Sign up"
		expect(page).to have_content("You have signed up successfully.")
	end
end
