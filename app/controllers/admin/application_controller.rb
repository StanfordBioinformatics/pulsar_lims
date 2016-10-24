class Admin::ApplicationController < ApplicationController
	before_action :authorize_admin!
	skip_after_action :verify_authorized
	skip_after_action :verify_policy_scoped

  def index
  end

	private
		def authorize_admin!
			authenticate_user!
			unless current_user.admin?
				redirect_to root_path, alert: "You must be an admin to perform that request."
			end
		end
end
