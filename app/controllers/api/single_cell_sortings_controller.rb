class Api::SingleCellSortingsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/single_cell_sortings/3
  before_action :set_single_cell_sorting, only: [:show, :update, :destroy]

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
    @single_cell_sortings = policy_scope(SingleCellSorting).order("lower(name)")
    render json: @single_cell_sortings
  end

  def show
    authorize @single_cell_sorting
    render json: @single_cell_sorting
  end

  def create
    @single_cell_sorting = SingleCellSorting.new(single_cell_sorting_params)
    @single_cell_sorting.user = @current_user
    authorize @single_cell_sorting
    if @single_cell_sorting.save
      render json: @single_cell_sorting, status: :created
    else
      render json: { errors: @single_cell_sorting.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @single_cell_sorting
    if @single_cell_sorting.update(single_cell_sorting_params)
      render json: @single_cell_sorting, status: 200
    else
      render json: { errors: @single_cell_sorting.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@single_cell_sorting)
  end

  private

  def set_single_cell_sorting
    @single_cell_sorting = SingleCellSorting.find(params[:id])
  end

  def single_cell_sorting_params
    params.require(:single_cell_sorting).permit(
        :description,
        :fluorescence_intensity_file,
        :library_prototype_id,
        :name,
        :notes,
        :sorting_biosample_id,
        :starting_biosample_id,
        :upstream_identifier,
        :document_ids => [],
        documents_attributes: [:id,:_destroy],
        library_prototype_attributes: [
          :biosample_id,
          :concentration,
          :concentration_unit_id,
          :is_control,
          :library_fragmentation_method_id,
          :lot_identifier,
          :name,
          :nucleic_acid_term_id,
          :paired_end,
          :prototype,
          :sequencing_library_prep_kit_id,
          :size_range,
          :strand_specific,
          :vendor_id,
          :vendor_product_identifier,
          :document_ids => []
        ],
        sorting_biosample_attributes: [
          :biosample_term_name_id,
          :biosample_type_id,
          :control,
          :date_biosample_taken,
          :description,
          :donor_id,
          :lot_identifier,
          :name,
          :part_of_id,
          :passage_number,
          :submitter_comments,
          :upstream_identifier,
          :vendor_id,
          :vendor_product_identifier,
          :document_ids => [],
          documents_attributes: [:id,:_destroy]
        ],
        plates_attributes: [
          :dimensions,
          :name,
          :notes,
          :starting_biosample_id,
          :vendor_id,
          :vendor_product_identifier,
          antibody_ids: []
        ],
        analyses_ids: []
    )
  end
end
