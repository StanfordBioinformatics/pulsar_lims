class Api::DocumentTypesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/document_types/3
  before_action :set_document_type, only: [:show, :update, :destroy]

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
    @document_types = policy_scope(DocumentType).order("lower(name)")
    render json: @document_types
  end

  def show
    authorize @document_type
    render json: @document_type
  end

  def create
    @document_type = DocumentType.new(document_type_params)
    @document_type.user = @current_user
    authorize @document_type
    if @document_type.save
      render json: @document_type, status: :created
    else
      render json: { errors: @document_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @document_type
    if @document_type.update(document_type_params)
      render json: @document_type, status: 200
    else
      render json: { errors: @document_type.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@document_type)
  end

  private

  def set_document_type
    @document_type = DocumentType.find(params[:id])
  end

  def document_type_params
    params.require(:document_type).permit(
      :name
    )
  end
end
