class Api::SequencingLibraryPrepKitsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/sequencing_library_prep_kits/3
  before_action :set_sequencing_library_prep_kit, only: [:show, :update, :destroy]

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
    @sequencing_library_prep_kits = policy_scope(SequencingLibraryPrepKit).order("lower(name)")
    render json: @sequencing_library_prep_kits
  end

  def show
    authorize @sequencing_library_prep_kit
    render json: @sequencing_library_prep_kit
  end

  def create
    @sequencing_library_prep_kit = SequencingLibraryPrepKit.new(sequencing_library_prep_kit_params)
    @sequencing_library_prep_kit.user = @current_user
    authorize @sequencing_library_prep_kit
    if @sequencing_library_prep_kit.save
      render json: @sequencing_library_prep_kit, status: :created
    else
      render json: { errors: @sequencing_library_prep_kit.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @sequencing_library_prep_kit
    if @sequencing_library_prep_kit.update(sequencing_library_prep_kit_params)
      render json: @sequencing_library_prep_kit, status: 200
    else
      render json: { errors: @sequencing_library_prep_kit.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@sequencing_library_prep_kit)
  end

  private

  def set_sequencing_library_prep_kit
    @sequencing_library_prep_kit = SequencingLibraryPrepKit.find(params[:id])
  end

  def sequencing_library_prep_kit_params
    params.require(:sequencing_library_prep_kit).permit(
        :description,
        :name,
        :notes,
        :supports_dual_indexing,
        :vendor_id,
        :vendor_product_identifier
    )
  end
end
