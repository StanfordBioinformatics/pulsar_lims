class ApplicationController < ActionController::Base
	include Pundit
	require 'exceptions'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	#before_action :check_signed_in
  after_action :verify_authorized, except: :index,
		unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, 
		unless: :devise_controller?


	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private

	def user_not_authorized
		flash[:alert] = "You are not authorized to perform this action."
		redirect_to(request.referrer || root_path)
	end
	
	def check_signed_in
		unless user_signed_in?
			flash[:alert] = "You must be singed in in order to use this web application."
			redirect_to root_path
		end
	end

end
