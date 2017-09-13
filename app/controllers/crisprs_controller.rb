class CrisprsController < ApplicationController
  before_action :set_crispr, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:select_chromosome_on_reference_genome, :select_crispr_construct]

	def select_crispr_construct
		#Function: Called via AJAX in the crispr form when the user clicks the "Add Crispr Construct" button. 
		#Parsed params : exclude_ids - Array of CrisprConstruct IDs to exclude from the selection.
		exclude_ids = params[:exclude_ids]
		@biosample = Biosample.new
		@crispr = Crispr.new
		@crispr_constructs = CrisprConstruct.where.not(id: exclude_ids)
		render layout: false
	end
	
  def select_chromosome_on_reference_genome
    @crispr = Crispr.new
		@crispr.build_genomic_integration_site
    @chromosomes = Chromosome.where(reference_genome_id: params["reference_genome_id"])
    render layout: false
  end

  def index
    @crisprs = policy_scope(Crispr).order("lower(name)")
  end

  def show
		authorize @crispr
  end

  def new
		authorize Crispr
    @crispr = Crispr.new
		@crispr.build_genomic_integration_site
  end

  def edit
		authorize @crispr
  end

  def create
		authorize Crispr
		#render json: params
		#return 
    @crispr = Crispr.new(crispr_params)

		@crispr.user = current_user

    respond_to do |format|
      if @crispr.save
        format.html { redirect_to @crispr, notice: 'Crispr was successfully created.' }
        format.json { render json: @crispr, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @crispr.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @crispr
    respond_to do |format|
      if @crispr.update(crispr_params)
        format.html { redirect_to @crispr, notice: 'Crispr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @crispr.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @crispr
		ddestroy(@crispr,crisprs_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crispr
      @crispr = Crispr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crispr_params
      params.require(:crispr).permit(:name, :donor_construct_id, genomic_integration_site_attributes: [:id, :chromosome_id, :start, :end], crispr_construct_ids: [], crispr_constructs_attributes: [:id, :_destroy] )
    end
end
