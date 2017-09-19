class Api::ConstructTagsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/construct_tags/3
	before_action :set_construct_tag, only: [:show]

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
			render json: @construct_tag, status: 201
		else
			render json: { errors: @construct_tag.errors.full_messages }, status: 422
		end
	end

	private

	def set_construct_tag
		@construct_tag = ConstructTag.find(params[:id])
	end

	def construct_tag_params
		params.require(:construct_tag).permit(:name,:description)
	end
end
