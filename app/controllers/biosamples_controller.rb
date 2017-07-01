class BiosamplesController < ApplicationController
	include DocumentsConcern #gives me add_documents(), remove_documents()
  before_action :set_biosample, only: [:show, :edit, :update, :destroy, :delete_biosample_document]
	skip_after_action :verify_authorized, only: [:select_biosample_term_name]

  # GET /biosamples
  # GET /biosamples.json


  def select_biosample_term_name
    @biosample = Biosample.new
    biosample_type = BiosampleType.find(params[:biosample][:biosample_type_id])
		biosample_type_name = biosample_type.name

		tissue = BiosampleType.find_by!(name: "tissue") #Uberon
		whole_organism = BiosampleType.find_by!(name: "whole organisms") #Uberon
		primary_cell = BiosampleType.find_by!(name: "primary cell") #CL
		stem_cell = BiosampleType.find_by!(name: "stem cell") #CL
		immortalized_cell_line = BiosampleType.find_by!(name: "immortalized cell line") #EFO
		induced_pluripotent_stem_cell = BiosampleType.find_by!(name: "induced pluripotent stem cell line") #EFO
		in_vitro_differentiated_cell = BiosampleType.find_by!(name: "in vitro differentiated cells") #CL or EFO

		@biosample_term_name_selection = BiosampleTermName.all
		if [tissue.name,whole_organism.name].include?(biosample_type_name)
			@biosample_term_name_selection = BiosampleTermName.uberon
		elsif [primary_cell.name, stem_cell.name].include?(biosample_type_name)
			@biosample_term_name_selection = BiosampleTermName.cl
		elsif [immortalized_cell_line.name,induced_pluripotent_stem_cell.name].include?(biosample_type_name)
			@biosample_term_name_selection = BiosampleTermName.efo
		elsif biosample_type_name == in_vitro_differentiated_cell.name
			@biosample_term_name_selection = BiosampleTermName.cl.merge(BiosampleTermName.efo)
		end
    render layout: false
  end

  def index
    @biosamples = policy_scope(Biosample).order("lower(name)")
  end

  # GET /biosamples/1
  # GET /biosamples/1.json
  def show
		authorize @biosample
  end

  # GET /biosamples/new
  def new
		@submit_btn = true
		authorize Biosample
    @biosample = Biosample.new
  end

  # GET /biosamples/1/edit
  def edit
		authorize @biosample
  end

  # POST /biosamples
  # POST /biosamples.json
  def create
		@submit_btn = true
		authorize Biosample
    @biosample = Biosample.new(biosample_params)
		@biosample.user = current_user
		@biosample = add_documents(@biosample,params[:biosample][:document_ids])
		
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

  # PATCH/PUT /biosamples/1
  # PATCH/PUT /biosamples/1.json
  def update
		authorize @biosample
		@biosample = add_documents(@biosample,params[:biosample][:documents])
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

  # DELETE /biosamples/1
  # DELETE /biosamples/1.json
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
      params.require(:biosample).permit(:prototype, :well_id, :parent_biosample_id, :control, :biosample_term_name_id, :submitter_comments, :lot_identifier, :vendor_product_identifier, :description, :passage_number, :culture_harvest_date, :encid, :donor_id,:vendor_id,:biosample_type_id,:name, documents_attributes: [:id,:_destroy])
    end
end
