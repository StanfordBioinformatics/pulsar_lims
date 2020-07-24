class Api::PcrsController < Api::ApplicationController
  before_action :set_pcr, only: [:show, :update, :destroy, :add_gel, :select_gel]
  skip_after_action :verify_authorized, only: [:add_gel, :select_gel]

  def add_gel
    defaults = INPUT_DEFAULTS["Gel"] 
    @gel = @pcr.build_gel(percentage: defaults["percentage_for_PCR"])
  end

  def select_gel
    render layout: false
  end

  def find_by
    #find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

  def index
    @pcrs = policy_scope(Pcr).order("lower(name)")
    render json: @pcrs
  end

  def show
    authorize @pcr
    render json: @pcr
  end
  
  def create
    @pcr = Pcr.new(pcr_params)
    @pcr.user = current_user
    authorize @pcr

    if @pcr.save
      render json: @pcr, status: :created 
    else
      render json: { errors: @pcr.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @pcr
    if @pcr.update(pcr_params)
      render json: @pcr, status: 200 
    else
      render json: { errors: @pcr.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@pcr)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcr
      @pcr = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pcr_params
      params.require(:pcr).permit(
          :amplicon_size,
          :analyst_id,
          :annealing_temperature,
          :biosample_id,
          :description,
          :document_id,
          :extension_time,
          :forward_primer_id,
          :gel_id,
          :genomic_dna_concentration,
          :genomic_dna_concentration_units_id,
          :genomic_dna_prep_date,
          :name,
          :notes,
          :num_cycles,
          :pcr_master_mix_id,
          :reverse_primer_id,
          :second_pcr_num_cycles,
          :success)
    end
end
