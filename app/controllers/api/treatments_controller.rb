class Api::TreatmentsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/treatments/3
  before_action :set_treatment, only: [:show]

  def find_by
    # find_by defined in ApplicationController#find_by.
    super(treatment_params)
  end

  def index
    @treatments = policy_scope(Treatment).order("lower(name)")
    render json: @treatments
  end

  def show
    authorize @treatment
    render json: @treatment
  end

  def create
    @treatment = Treatment.new(treatment_params)
    @treatment.user = @current_user
    authorize @treatment
    if @treatment.save
      render json: @treatment, status: 201
    else
      render json: { errors: @treatment.errors.full_messages }, status: 422
    end
  end

  private

  def set_treatment
    @treatment = Treatment.find(params[:id])
  end

  def treatment_params
    params.require(:treatment).permit(                                                               
      :concentration,                                                                                
      :concentration_unit_id,                                                                        
      :description,                                                                                  
      :duration,                                                                                     
      :duration_units,                                                                               
      :name,                                                                                         
      :temperature,                                                                                  
      :treatment_term_name_id,                                                                       
      :treatment_type,                                                                               
      :upstream_identifier,                                                                          
      :document_ids => [],                                                                           
      :treatment_ids => []                                                                           
    )  
  end
end
