class UserMailer < Devise::Mailer
  #custom devise mailer. See instructions at https://github.com/plataformatec/devise/wiki/how-to:-use-custom-mailer.
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "New Account on #{ENV["APP_NAME"]}"
    opts[:from] = ENV["SUPPORT_EMAIL_ADDR"] #set in applia
    super
  end

end
