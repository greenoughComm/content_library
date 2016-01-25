class Notifier < ApplicationMailer
	def password_reset(user)
		@user = user
		mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>",
			 subject: "Reset Your Password")
	end
end
