class ApplicationController < ActionController::Base
	include Pundit
	require 'exceptions'
  require 'application_logic'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_model_class, only: [:index, :new]
	#before_action :check_signed_in
  after_action :verify_authorized, except: :index,
		unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, 
		unless: :devise_controller?

  skip_after_action :verify_authorized, only: :select_options

  rescue_from ActiveRecord::InvalidForeignKey, with: :foreign_key_constraint
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
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

  def set_model_class
    #@model_class is used particularly in the views/application_partials/_index_common_table_headers.html
    begin
      @model_class = controller_path.classify.constantize
    rescue NameError #i.e. NameError (uninitialized constant Welcome)
    end
  end

	def set_record(model_name, id_prop)
		# Function : Call this method in individual controllers to set the instance variable. 
		# Args     : model_name - The value of controller_name(), which the caller supplies in the controller.
		#              See https://apidock.com/rails/ActionController/Metal/controller_name/class.
    #          : id_prop - The value of a record's "id" property.
		# Returns  : An instance of the model that is represented by the model_name argument.
		model = model_name.classify.constantize
		begin
			rec = model.find(id_prop)
		rescue ActiveRecord::RecordNotFound
			return
		end
		return rec
	end

  def record_not_destroyed(err)
    flash[:alert] = err.record.errors.full_messages
    redirect_to(request.referrer || root_path) 
  end
  
  def foreign_key_constraint(err)
    flash[:alert] = err.message
		redirect_to(request.referrer || root_path)
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
