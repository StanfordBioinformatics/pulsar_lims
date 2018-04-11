class Admin::ApplicationController < ApplicationController
	before_action :authorize_admin!
	skip_after_action :verify_authorized
	skip_after_action :verify_policy_scoped

  def index
  end

	private
		def authorize_admin!
      # authenticate_user! method is provided by Devise to ensure that the user is signed in. If 
      # the user isn’t signed in, they will be redirected to the sign-in page (from Rails 4 in Action, 
      # p. 179). 
			authenticate_user!
			unless current_user.admin?
				redirect_to root_path, alert: "You must be an admin to perform that request."
			end
		end
end
