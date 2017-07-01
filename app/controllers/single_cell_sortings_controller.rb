class SingleCellSortingsController < ApplicationController
  before_action :set_single_cell_sorting, only: [:show, :edit, :update, :destroy, :add_sorting_biosample, :add_plate]
	skip_after_action :verify_authorized, only: [:add_sorting_biosample, :add_plate]


	def add_plate
		@single_cell_sorting.plates.build
		render partial: "plates/form", layout: false
	end

  def add_sorting_biosample
    sorting_biosample = @single_cell_sorting.starting_biosample.dup
    sorting_biosample.parent_biosample =  @single_cell_sorting.starting_biosample
		sorting_biosample.prototype = true
    sorting_biosample.name =  @single_cell_sorting.name + " " + "prototype"
    @biosample = sorting_biosample
    #@biosample = @single_cell_sorting.build_sorting_biosample(sorting_biosample.attributes)
    #render partial: "biosamples/form", layout: false
    render partial: "add_sorting_biosample", layout: false
  end 

  def index
    @single_cell_sortings = policy_scope(SingleCellSorting)
  end

  def show
		authorize @single_cell_sorting
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @single_cell_sorting }
    end
  end

  def new
		authorize SingleCellSorting
    @single_cell_sorting = SingleCellSorting.new
		@starting_biosample_collection = Biosample.non_well_biosamples
  end

  def edit
		authorize @single_cell_sorting
  end

  def create
		authorize SingleCellSorting
    @single_cell_sorting = SingleCellSorting.new(single_cell_sorting_params)
		@single_cell_sorting.user = current_user

    respond_to do |format|
      if @single_cell_sorting.save
        format.html { redirect_to @single_cell_sorting, notice: 'Single cell sorting was successfully created.' }
        format.json { render json: @single_cell_sorting, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @single_cell_sorting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @single_cell_sorting
		sorting_biosample_attributes = single_cell_sorting_params[:sorting_biosample_attributes]
		if sorting_biosample_attributes.present? and not sorting_biosample_attributes.include?(:id)
			sorting_biosample = @single_cell_sorting.build_sorting_biosample(sorting_biosample_attributes)
			sorting_biosample.user = current_user
			params.delete(:sorting_biosample_attributes)
		end
    respond_to do |format|
      if @single_cell_sorting.update(single_cell_sorting_params)
        format.html { redirect_to @single_cell_sorting, notice: 'Single cell sorting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @single_cell_sorting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @single_cell_sorting
    @single_cell_sorting.destroy
    respond_to do |format|
      format.html { redirect_to single_cell_sortings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_single_cell_sorting
      @single_cell_sorting = SingleCellSorting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def single_cell_sorting_params
      params.require(:single_cell_sorting).permit(:starting_biosample_id, :sorting_biosample, :name, :description, sorting_biosample_attributes: [:prototype, :parent_biosample_id, :control, :biosample_term_name_id, :submitter_comments, :lot_identifier, :vendor_product_identifier, :description, :passage_number, :culture_harvest_date, :encid, :donor_id,:vendor_id,:biosample_type_id,:name, documents_attributes: [:id,:_destroy]])
    end
end
