class ApplicationMailer < ActionMailer::Base
  default_url_options[:host] = "localhost:3000"
  default from: "from@example.com"
  layout 'mailer'
end
