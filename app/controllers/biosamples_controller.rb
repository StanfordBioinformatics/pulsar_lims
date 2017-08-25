class BiosamplesController < ApplicationController
#	include DocumentsConcern #gives me add_documents(), remove_documents()
  before_action :set_biosample, only: [:show, :edit, :update, :destroy, :delete_biosample_document]
	skip_after_action :verify_authorized, only: [:select_biosample_term_name]

  def select_biosample_term_name
    @biosample = Biosample.new
    biosample_type = BiosampleType.find(params[:biosample_type_selector])
		@biosample_term_name_selection = BiosampleType.get_biosample_term_names(biosample_type.id)
    render layout: false
  end

  def index
    @biosamples = policy_scope(Biosample).order("lower(name)")
  end

  def show
		authorize @biosample
  end

  def new
		authorize Biosample
    @biosample = Biosample.new
  end

  def edit
		authorize @biosample
  end

  def create
		authorize Biosample
    @biosample = Biosample.new(biosample_params)
		@biosample.user = current_user
		#@biosample = add_documents(@biosample,params[:biosample][:document_ids])
		
    respond_to do |format|
      if @biosample.save
        format.html { redirect_to @biosample, notice: 'Biosample was successfully created.' }
        format.json { render action: 'show', status: :created, location: @biosample }
      else
        format.html { render action: 'new' }
        format.json { render json: @biosample.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @biosample
		#@biosample = add_documents(@biosample,params[:biosample][:documents])
    respond_to do |format|
      if @biosample.update(biosample_params)
        format.html { redirect_to @biosample, notice: 'Biosample was successfully updated.' }
        format.json { head :no_content }
      else
				format.html { render "edit" }
        format.json { render json: @biosample.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @biosample
    respond_to do |format|
    	if @biosample.destroy
	      format.html { redirect_to biosamples_url, notice: "Biosample has been deleted." }
 	     format.json { head :no_content }
			else 
				format.html { render action: 'show' }
        format.json { render json: @biosample.errors, status: :unprocessable_entity }
			end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biosample
      @biosample = Biosample.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The biosample you were looking for could not be found."
			redirect_to biosamples_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biosample_params
      params.require(:biosample).permit(:from_prototype_id, :prototype, :well_id, :parent_biosample_id, :control, :biosample_term_name_id, :submitter_comments, :lot_identifier, :vendor_product_identifier, :description, :passage_number, :culture_harvest_date, :encid, :donor_id,:vendor_id,:biosample_type_id,:name, :document_ids => [], documents_attributes: [:id,:_destroy])
    end
end
