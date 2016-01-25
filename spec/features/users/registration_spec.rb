require "spec_helper"

describe "signing up" do
	it "at user/new, sudo can create new user" do
		expect(User.count).to eq(0)

		visit"/users/new"
		fill_in "Name", with: "Test"
		fill_in "Email", with: "Test@test.com"
		fill_in "Password", with: "newpassword"
		fill_in "Password confirmation", with: "newpassword"
		click_button "Create User"

		expect(User.count).to eq(1)
	end
end