class Api::ConstructTagsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/construct_tags/3
	before_action :set_construct_tag, only: [:show]

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
		@construct_tags = policy_scope(ConstructTag).order("lower(name)")
		render json: @construct_tags
	end

	def show
		authorize @construct_tag
		render json: @construct_tag
	end

	def create
		@construct_tag = ConstructTag.new(construct_tag_params)
		@construct_tag.user = @current_user
		authorize @construct_tag
		if @construct_tag.save
			render json: @construct_tag, status: :created
		else
			render json: { errors: @construct_tag.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def set_construct_tag
		@construct_tag = ConstructTag.find(params[:id])
	end

	def construct_tag_params
		params.require(:construct_tag).permit(
      :user_id,
      :name,
      :notes,
      :description
    )
	end
end
