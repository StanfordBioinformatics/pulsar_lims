class Api::WellsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/wells/3
  before_action :set_well, only: [:show, :update, :destroy]

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
    @wells = policy_scope(Well).order("lower(name)")
    render json: @wells
  end

  def show
    authorize @well
    render json: @well
  end

  def create
    @well = Well.new(well_params)
    @well.user = @current_user
    authorize @well
    if @well.save
      render json: @well, status: :created
    else
      render json: { errors: @well.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @well
    if @well.update(well_params)
      render json: @well, status: 200
    else
      render json: { errors: @well.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@well)
  end

  private

  def set_well
    @well = Well.find(params[:id])
  end

  def well_params
    params.require(:well).permit(
      :fail,
      :comment
    )
  end
end
