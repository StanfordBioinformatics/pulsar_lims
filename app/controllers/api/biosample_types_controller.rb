class Api::BiosampleTypesController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosample_types/3
	before_action :set_biosample_type, only: [:show]

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
		@biosample_types = policy_scope(BiosampleType).order("lower(name)")
		render json: @biosample_types
	end

	def show
		authorize @biosample_type
		render json: @biosample_type
	end

	def create
		@biosample_type = BiosampleType.new(biosample_type_params)
		@biosample_type.user = @current_user
		authorize @biosample_type
		if @biosample_type.save
			render json: @biosample_type, status: 201
		else
			render json: { errors: @biosample_type.errors.full_messages }, status: 422
		end
	end

	private

	def set_biosample_type
		@biosample_type = BiosampleType.find(params[:id])
	end

	def biosample_type_params
		params.require(:biosample_type).permit(
      :user_id,
      :name,
      :tissue
    )
	end
end
