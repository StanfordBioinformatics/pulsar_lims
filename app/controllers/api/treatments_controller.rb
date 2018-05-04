class Api::TreatmentsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/treatments/3
  before_action :set_treatment, only: [:show]

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
      :user_id,
      :concentration,
      :concentration_unit_id,
      :description,
      :duration,
      :duration_units,
      :name,
      :notes,
      :temperature_celsius,
      :treatment_term_name_id,
      :treatment_type,
      :upstream_identifier,
      :document_ids => [],
      :treatment_ids => []
    )
  end
end
