class Api::LibraryFragmentationMethodsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/library_fragmentation_methods/3
  before_action :set_library_fragmentation_method, only: [:show, :update, :destroy]

  def find_by
    # find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

  def index
    @library_fragmentation_methods = policy_scope(LibraryFragmentationMethod).order("lower(name)")
    render json: @library_fragmentation_methods
  end

  def show
    authorize @library_fragmentation_method
    render json: @library_fragmentation_method
  end

  def create
    @library_fragmentation_method = LibraryFragmentationMethod.new(library_fragmentation_method_params)
    @library_fragmentation_method.user = @current_user
    authorize @library_fragmentation_method
    if @library_fragmentation_method.save
      render json: @library_fragmentation_method, status: :created
    else
      render json: { errors: @library_fragmentation_method.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @library_fragmentation_method
    if @library_fragmentation_method.update(library_fragmentation_method_params)
      render json: @library_fragmentation_method, status: 200
    else
      render json: { errors: @library_fragmentation_method.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@library_fragmentation_method)
  end

  private

  def set_library_fragmentation_method
    @library_fragmentation_method = LibraryFragmentationMethod.find(params[:id])
  end

  def library_fragmentation_method_params
    params.require(:library_fragmentation_method).permit(
      :name,                                                                                        
      :notes,                                                                                   
      :description
    )
  end
end
