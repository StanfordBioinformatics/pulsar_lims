class Api::ConcentrationUnitsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/concentration_units/3
	before_action :set_concentration_unit, only: [:show]

  def find_by
    # find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super(concentration_unit_params)
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super(concentration_unit_params)
  end

	def index
		@concentration_units = policy_scope(ConcentrationUnit).order("lower(name)")
		render json: @concentration_units
	end

	def show
		authorize @concentration_unit
		render json: @concentration_unit
	end

	def create
		@concentration_unit = ConcentrationUnit.new(concentration_unit_params)
		@concentration_unit.user = @current_user
		authorize @concentration_unit
		if @concentration_unit.save
			render json: @concentration_unit, status: 201
		else
			render json: { errors: @concentration_unit.errors.full_messages }, status: 422
		end
	end

	private

	def set_concentration_unit
		@concentration_unit = ConcentrationUnit.find(params[:id])
	end

	def concentration_unit_params
		params.require(:concentration_unit).permit(:name)
	end
end
