class ApplicationMailer < ActionMailer::Base
  default from: ENV["APP_EMAIL_ADDR"]
  default from: "postmaster@pulsar-encode.stanford.edu"
  layout 'mailer'
end
