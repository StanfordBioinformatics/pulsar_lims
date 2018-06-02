class WelcomeController < ApplicationController
  skip_before_action :check_signed_in
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
  end
end
