class Api::ApplicationController < ApplicationController
	protect_from_forgery with: :null_session
	attr_reader :current_user
	before_action :authenticate_user

	private

	def user_not_authorized
		#overwrites the method defined in controllers/application_controller. This is a rescue-from callback. 
		render json: { error: "Forbidden" }, status: 403
	end

	def authenticate_user
    #The RAILS method authenticate_with_http_token checks the Authorization request header for a token and passes it
    # as an argument to the given block.
    # See (https://www.codeschool.com/blog/2014/02/03/token-based-authentication-rails/)

		authenticate_with_http_token do |token|
			@current_user = User.find_by(api_key: token)
			if @current_user.nil?
        response.headers["WWW-Authenticate"] = "Token realm=Application"
				render json: { error: "Unauthorized" }, status: 401
				return
			end
		end
	end
end
