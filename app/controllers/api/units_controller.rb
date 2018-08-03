class Api::UnitsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/units/3
  before_action :set_unit, only: [:show, :update, :destroy]

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
    @units = policy_scope(Unit).order("lower(name)")
    render json: @units
  end

  def show
    authorize @unit
    render json: @unit
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.user = @current_user
    authorize @unit
    if @unit.save
      render json: @unit, status: 201
    else
      render json: { errors: @unit.errors.full_messages }, status: 422
    end
  end

  def update
    authorize @unit
    if @unit.update(unit_params)
      render json: @unit, status: 200
    else
      render json: { errors: @unit.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@unit)
  end

  private

  def set_unit
    @unit = Unit.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(
      :user_id,
      :name
    )
  end
end
