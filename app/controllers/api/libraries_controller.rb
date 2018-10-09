class Api::LibrariesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/librarys/3
  before_action :set_library, only: [:show, :update, :destroy]

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
    @librarys = policy_scope(Library).order("lower(name)")
    render json: @librarys
  end

  def show
    authorize @library
    render json: @library
  end

  def create
    @library = Library.new(library_params)
    @library.user = @current_user
    authorize @library
    if @library.save
      render json: @library, status: :created
    else
      render json: { errors: @library.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @library
    if @library.update(library_params)
      render json: @library, status: 200
    else
      render json: { errors: @library.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@library)
  end

  private

  def set_library
    @library = Library.find(params[:id])
  end

  def library_params
    params.require(:library).permit(
        :barcode_id,
        :biosample_id,
        :concentration,
        :concentration_unit_id,
        :dual_indexed,
        :from_prototype_id,
        :library_fragmentation_method_id,
        :lot_identifier,
        :name,
        :notes,
        :nucleic_acid_term_id,
        :upstream_identifier,
        :paired_barcode_id,
        :prototype,
        :sequencing_library_prep_kit_id,
        :size_range,
        :strand_specific,
        :times_cloned,
        :vendor_id,
        :vendor_product_identifier,
        :document_ids => [],
        documents_attributes: [:id, :_destroy],
        sequencing_requests_attributes: [:id, :_destroy],
        barcode_attributes: [:id, :_destroy],
        paired_barcode_attributes: [:id, :_destroy]
    )
  end
end
