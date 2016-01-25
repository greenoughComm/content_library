require 'spec_helper'

describe PasswordResetsController do
	describe "GET new" do
		it "renders the new template" do
			get :new
			expect(response).to render_template('new')
		end
	end

	describe "POST create" do
		context "with a valid user and email" do
			let!(:user) { user = User.create(first_name: "Test", last_name: "Tester", email: "test@test.com", password: "newpassword", password_confirmation: "newpassword") }
			
			it "finds the user" do
				expect(User).to receive(:find_by).with(email: user.email).and_return(user)
				post :create, email: user.email
			end

			it "generates a new pw reset token" do
				expect{ post :create, email: user.email; user.reload }.to change(user, :password_reset_token)
			end

			it "sends a password reset email" do
				expect{ post :create, email: user.email }.to change(ActionMailer::Base.deliveries, :size)
			end

			it "displays a success message" do
				post :create, email: user.email
				expect(flash[:success]).to match(/check your email/)
			end
		end

		context "with no user found" do
			it "renders the new page" do
				post :create, email: 'none@none.com'
				expect(response).to render_template('new')
			end

			it "displays an error" do
				post :create, email: 'none@none.com'
				expect(flash[:notice]).to match(/not found/)
			end
		end
	end

	describe "GET edit" do
		context "with a valid pw reset token" do
			let!(:user) { user = User.create(first_name: "Test", last_name: "Tester", email: "test@test.com", password: "newpassword", password_confirmation: "newpassword") }
			before { user.generate_password_reset_token! }

			it "renderes the edit template" do
				get :edit, id: user.password_reset_token
				expect(response).to render_template('edit')
			end

			it "assigns a @user" do
				get :edit, id: user.password_reset_token
				expect(assigns(:user)).to eq(user)
			end
		end

		context "with no pw reset token" do
			it "renders 404" do
				get :edit, id: "none"
				expect(response.status).to eq(404)
			end
		end
	end

	describe "PATCH update" do
		context "with no token" do
			it "renders edit page" do
				patch :update, id: 'none', user: { password: 'nonepassword', password_confirmation: 'nonepassword' }
				expect(response).to render_template('edit')
			end

			it "sets message" do
				patch :update, id: 'notfound', user: { password: 'nonepassword', password_confirmation: 'nonepassword' }
				expect(flash[:notice]).to match(/Invalid/)
			end
		end

		context 'with valid token' do
			let!(:user) { user = User.create(first_name: "Test", last_name: "Tester", email: "test@test.com", password: "newpassword", password_confirmation: "newpassword") }
			before { user.generate_password_reset_token! }

			it "updates user password" do
				old_digest = user.password_digest
				patch :update, id: user.password_reset_token, user: { password: 'newnewpassword', password_confirmation: 'newnewpassword'}
				user.reload
				expect(user.password_digest).to_not eq(old_digest)
			end

			it "clears password_reset_token" do
				patch :update, id: user.password_reset_token, user: { password: 'newnewpassword', password_confirmation: 'newnewpassword'}
				user.reload
				expect(user.password_reset_token).to be_blank
			end

			it "logs the user in if reset is successful" do
				patch :update, id: user.password_reset_token, user: { password: 'newnewpassword', password_confirmation: 'newnewpassword'}
				expect(session[:user_id]).to eq(user.id)
			end

			it "shows success message" do
				patch :update, id: user.password_reset_token, user: { password: 'newnewpassword', password_confirmation: 'newnewpassword'}
				expect(flash[:success]).to match(/Password updated/i)
			end
		end
	end
end