require "spec_helper"

describe "Forgotten passwords" do
	let!(:user) { user = User.create(first_name: "Test", last_name: "Tester", email: "test@test.com", password: "newpassword", password_confirmation: "newpassword") }

	it 'sends user an email' do
		visit new_session_path
		click_link "Forgot Password?"
		fill_in "Email", with: user.email
		expect {
			click_button "Reset"
		}.to change{ ActionMailer::Base.deliveries.size }.by(1)
	end

	it "resets a password after email link" do
		visit new_session_path
		click_link "Forgot Password?"
		fill_in "Email", with: user.email
		click_button "Reset"
		open_email(user.email)
		current_email.click_link "http://"
		expect(page).to have_content(/Change Your Password/i)
	
		fill_in "New Password", with: "newpassword"
		fill_in "Confirm New Password", with: "newpassword"
		click_button "Change Password"
		expect(page.current_path).to eq(new_session_path)
	end
end