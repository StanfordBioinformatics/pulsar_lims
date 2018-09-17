class Api::FileReferencesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/file_references/3
  before_action :set_file_reference, only: [:show, :update, :destroy]

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
    @file_references = policy_scope(FileReference).order("lower(name)")
    render json: @file_references
  end

  def show
    authorize @file_reference
    render json: @file_reference
  end

  def create
    @file_reference = FileReference.new(file_reference_params)
    @file_reference.user = @current_user
    authorize @file_reference
    if @file_reference.save
      render json: @file_reference, status: :created
    else
      render json: { errors: @file_reference.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @file_reference
    if @file_reference.update(file_reference_params)
      render json: @file_reference, status: 200
    else
      render json: { errors: @file_reference.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@file_reference)
  end

  private

  def set_file_reference
    @file_reference = FileReference.find(params[:id])
  end

  def file_reference_params
    params.require(:file_reference).permit(
        :data_file_type_id,
        :data_storage_id,
        :file_path,
        :fileid,
        :notes
    )
  end
end
