class ApplicationController < ActionController::Base
  include Pundit
  require 'exceptions'
  require 'application_logic'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Set @model_class instance
  before_action :set_model_class, only: [:index, :new, :show, :find_by, :find_by_or]
  # Note that :find_by is defined as an action in controller subclasses, which are expected to
  # call the prviate :find_by method defined here (not as an action), particularly the api
  # controllers.
  #before_action :check_signed_in
  after_action :verify_authorized, except: :index,
    unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index,
    unless: :devise_controller?

  skip_after_action :verify_authorized, only: [:select_options]

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  rescue_from ActiveRecord::InvalidForeignKey, with: :foreign_key_constraint
  rescue_from ActiveRecord::RecordNotDestroyed, with: :record_not_destroyed
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  #ActiveRecord::DeleteRestrictionError is raised when there is a model dependency that sets
  # "dependent: :restrict_with_exception" and deleting the model would result in a foreign key error.
  # For an example of this, see the biosample model.
  rescue_from ActiveRecord::DeleteRestrictionError, with: :destroy_not_allowed

  private

  def ddestroy(record, redirect_path_success: nil)
    #Named somewhat strangely as ddestroy instead of destroy in order to
    # not overwrite the destroy() method in the controllers that inherit from here.
    # The idea is that each individual controller's destroy() method will call this one
    # in order to avoid duplicating logic and make updates a breeze.
    authorize record
    respond_to do |format|
      if record.destroy
        format.html { redirect_to redirect_path_success }
        format.json { head :no_content }
      else
        format.html { render Rails.application.routes.recognize_path(request.referer)[:action] }
        format.json { render json: record.errors.full_messages,status: :unprocessable_entity }
      end
    end
  end

  def index(scope: nil, where: {})
    @records = policy_scope(@model_class).where(where)
    if scope.present?
      @records = @records.send(scope)
    end
    @records = @records.unscoped.order(updated_at: :desc)
    @total = @records.count
    unless params[:all].present?
      @records = @records.page params[:page]
      @page = true
    end
  end

  def find_by
    # Used in API calls to invoke find_by from ActiveRecord::FinderMethods by passing in the params
    # argument, which is a dict. Thus, all query parameters in the dict are joined implicitly via
    # the AND database operator (since that is the behavior of Rails's find_by when given a dict).
    # For OR operator joining, see the mothod find_by_or defined below.
    #
    # Uses @model_class from ApplicationController#set_model_class.
    authorize @model_class, :show?
    # Check if params is empty and if so, return an empty JSON object.
    # Need to make this check because the Rails find_by method will return the first record by
    # default when given an empty search criterion.
    if params.empty?
        render json: {}
        return
    end
    res = @model_class.find_by(params[:find_by].to_hash)
    # NOTE ON ABOVE: I have to add the call to to_hash() since w/o it, we'll get the RAILS error
    # ActiveModel::ForbiddenAttributesError. That is becuase were using the raw params, and not
    # parsing them out in a controller specific method that calls params.required().
    render json: res
  end

  def find_by_or
    # Used in API calls to invoke find_by from ActiveRecord::FinderMethods.
    # The 'params' argument is a dict, however, to allow OR operator joining, this method
    # creates a string query out of params' that includes calls to the OR operator for each
    # query parameter in params. For AND operator joining, see find_by method defined above.
    #
    # Uses @model_class from ApplicationController#set_model_class.
    authorize @model_class, :show?
    # Check if params is empty and if so, return an empty JSON object.
    # Need to make this check because the Rails find_by method will return the first record by
    # default when given an empty search criterion.
    if params.empty?
        render json: {}
        return
    end
    search_str = ""
    replacement_args = []
    params[:find_by_or].to_hash.each do |key, val|
      replacement_args << val
      search_str += "#{key} = ? OR "
    end
    search_str = search_str.chomp(" OR ")
    res = @model_class.find_by(search_str, *replacement_args)
    render json: res
  end

  def set_model_class
    # @model_class is used particularly in the views/application_partials/_index_common_table_headers.html
    # Need to be careful if the caller is a controller in the api namespace, for example, the find_by()
    # method in api/documents_controller.rb makes a call to 'super', thereby calling the private method
    # by the same name that exists in this present class, which in turn calls this present method.
    # In this case, we have the following assertions that can be made:
    #
    #  1. controller_path == "api/documents"
    #  2. controller_path.classify == "Api:Document"
    #
    # As you can see, we need to remove the "api" prefix before the full call to
    # controller_path.classify.constantize is made, which can be done by splitting on ":".
    # Of course, care must be taken when calling this set_model_class method when the caller represents
    # a controller that doesn't pair to any model, i.e. the welcome controller, as this method won't work
    # and a NameError will be raised and caught.
    begin
      @model_class = controller_path.classify.split(":")[-1].constantize
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
      flash[:alert] = "Record not found."
      redirect_to(request.referer || root_path)
    end
    return rec
  end

  def record_not_destroyed(err)
    # Error handler for ActiveRecord::RecordNotDestroyed.
    respond_to do |format|
      format.html {
        flash[:alert] = err.record.errors.full_messages
        redirect_to(request.referrer || root_path)
      }
      format.json {
        render json: {exception: "ActiveRecord::RecordNotDestroyed", message: err.message}, status: 403
      }
    end
  end

  def invalid_record(err)
    # Error handler for ActiveRecord::RecordInvalid.
    respond_to do |format|
      format.html {
        flash[:alert] = err.message
        redirect_to(request.referrer || root_path)
      }
      format.json  {
        render json: {exception: "ActiveRecord::RecordInvalid", message: err.message}, status: 403
      }
    end
  end

  def foreign_key_constraint(err)
    # Error handler for ActiveRecord::InvalidForeignKey.
    respond_to do |format|
      format.html {
        flash[:alert] = err.message
        redirect_to(request.referrer || root_path)
      }
      format.json  {
        render json: {exception: "ActiveRecord::InvalidForeignKey", message: err.message}, status: 403
      }
    end
  end

  def user_not_authorized
    # Error handler for Pundit::NotAuthorizedError.
    respond_to do |format|
      format.html {
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
      }
      #Why json here and not in API? Because the app internally makes some AJAX calls to
      # non API-end points. These should later be migrated to API endpoint calls, however.
      format.json {
        response.headers["WWW-Authenticate"] = "Token realm=Application"
        render json: { error: "Unauthorized" }, status: 401
      }
    end

  end

  def destroy_not_allowed(err)
    # Error handler for ActiveRecord::DeleteRestrictionError.
    respond_to do |format|
      format.html {
        flash[:alert] = err.message
        redirect_to(request.referrer || root_path)
      }
      #Why json here and not in API? Because the app internally makes some AJAX calls to
      # non API-end points. These should later be migrated to API endpoint calls, however.
      format.json {
        render json: {exception: err.class.name, message: err.message},  status: 403
      }
    end
  end

  def check_signed_in
    unless user_signed_in?
      flash[:alert] = "You must be singed in in order to use this web application."
      redirect_to root_path
    end
  end

end
