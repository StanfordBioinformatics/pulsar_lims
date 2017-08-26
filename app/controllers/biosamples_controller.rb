class BiosamplesController < ApplicationController
#	include DocumentsConcern #gives me add_documents(), remove_documents()
  before_action :set_biosample, only: [:show, :edit, :update, :destroy, :delete_biosample_document]
	skip_after_action :verify_authorized, only: [:select_biosample_term_name]

  def select_biosample_term_name
    biosample_type = BiosampleType.find(params[:biosample_type_selector])
		biosample_term_name_id = params[:biosample_term_name_selector]
		#here I pass in param biosample_term_name_selector in biosamples.js.coffee in order to save the 
		# selected biosample_term_name, if there is one selected. That way, if there is a validation error
		# when the user submits the form (perhaps regarding some other field), I can set the biosample_term_name 
    # to what the user had already set it to.  Normally, it would be reset to what it was since on a page re-render, 
		# the AJAX request goes through again to repopulate the list of possible values for the biosample_term_name, based on teh
		# biosample_type selection.
    biosample_term_name = nil
		if biosample_term_name_id.present?
			biosample_term_name = BiosampleTermName.find(biosample_term_name_id)
		end
		@biosample_term_name_selection = BiosampleType.get_biosample_term_names(biosample_type.id)
		@selected = nil
		if biosample_term_name.present?
			@selected = biosample_term_name.id
		end
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
