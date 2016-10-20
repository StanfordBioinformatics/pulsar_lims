class ApplicationController < ActionController::Base
	include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	#before_action :check_signed_in


	private
	
	def check_signed_in
		unless user_signed_in?
			flash[:alert] = "You must be singed in in order to use this web application."
			redirect_to root_path
		end
	end

end
