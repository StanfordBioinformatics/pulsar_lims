class Api::CrisprConstructsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/crispr_constructs/3
	before_action :set_crispr_construct, only: [:show]

	def show
		authorize @crispr_construct
		render json: @crispr_construct
	end

	def create
		@crispr_construct = CrisprConstruct.new(crispr_construct_params)
		authorize @crispr_construct, :create?
		if @crispr_construct.save
			render json: @crispr_construct, status: 201
		else
			render json: { errors: @crispr_construct.errors.full_messages }, status: 422
		end
	end

	private

	def set_crispr_construct
		@crispr_construct = CrisprConstruct.find(params[:id])
	end

	def crispr_construct_params
		params.require(:crispr_construct).permit(:name, :target_id, :guide_sequence, :cloning_vector_id, :description, :vendor_id, :vendor_product_identifier, crispr_tag_ids: [])
	end
end
