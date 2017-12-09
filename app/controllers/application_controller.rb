class ApplicationController < ActionController::Base
	include Pundit
	require 'exceptions'
  require 'application_logic'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	#before_action :check_signed_in
  after_action :verify_authorized, except: :index,
		unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, 
		unless: :devise_controller?


	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	rescue_from ActiveRecord::DeleteRestrictionError, with: :destroy_not_allowed

	def ddestroy(record,redirect_path_success)
		#Named somewhat strangely as ddestroy instead of destroy in order to 
		# not overwrite the destroy() method in the controllers that inherit from here.
		# The idea is that each individual controller's destroy() method will call this one
		# in order to avoid duplicating logic and make updates a breeze. 
    respond_to do |format|
      if record.destroy
        format.html { redirect_to redirect_path_success }
        format.json { head :no_content }
      else
        #format.html { render action: 'show' }
        format.html { render Rails.application.routes.recognize_path(request.referer)[:action] }
        format.json { render json: @record.errors.full_messages,status: :unprocessable_entity }
      end 
    end 
	end

	private

	def set_record(model_name, id_param)
		# Function : Call this method in individual controllers to set the instance variable. 
		# Args     : model_name - The value of controller_name(), which the caller supplies in the controller.
		#              See https://apidock.com/rails/ActionController/Metal/controller_name/class.
		# Returns  : An instance of the model that is represented by the model_name argument.
		model = model_name.classify.constantize
		if /^[[:alpha:]]/.match(id_param)
			id_param = id_param.split("-")[1]
		end
		return model.find(id_param)
	end

	def user_not_authorized
		flash[:alert] = "You are not authorized to perform this action."
		redirect_to(request.referrer || root_path)
	end
	
	def destroy_not_allowed(err)
		flash[:alert] = err.message
		redirect_to(request.referrer || root_path)
	end

	def check_signed_in
		unless user_signed_in?
			flash[:alert] = "You must be singed in in order to use this web application."
			redirect_to root_path
		end
	end

end
