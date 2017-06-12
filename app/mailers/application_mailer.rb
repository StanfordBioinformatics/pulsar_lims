class ApplicationMailer < ActionMailer::Base
  default from: ENV["SUPPORT_EMAIL_ADDR"]
  layout 'mailer'
end
