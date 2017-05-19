class API::TicketsController < ApplicationController
	attr_reader :current_user
	before_action :authenticate_user

	private

	def user_not_authorized
		#overwrites the method defined in controllers/application_controller
		render json: { error: "Unauthorized" }, status: 403
	end

	def authenticate_user
		authenticate_with_http_token do |token|
		#authenticate_with_http_token is a rails method
		@current_user = User.find_by(api_key: token)
		if @current_user.nil?
			render json: { error: "Unauthorized" }, status: 401
			return
		end
	end
end
