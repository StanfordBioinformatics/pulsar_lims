class Api::BiosamplesController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosamples/3
	before_action :set_biosample, only: [:show, :update, :destroy, :add_crispr_modification]

	def index
		biosamples = policy_scope(Biosample).order("lower(name)")
		render json: biosamples
	end

	def show
		authorize @biosample
		render json: @biosample
	end

	def create
		@biosample = Biosample.new(biosample_params)
		authorize @biosample, :create?
		if @biosample.save
			render json: @biosample, status: 201
		else
			render json: { errors: @biosample.errors.full_messages }, status: 422
		end
	end

	def update
		authorize @biosample
		if @biosample.update(biosample_params)
			render json: @biosample, status: 204
		else
			render json: { errors: @biosample.errors.full_messages }, status: 422
		end
	end

	def destroy
		authorize @biosample
		if @biosample.destroy
			render json: @biosample, status: 204
		else
			render json: { errors: @biosample.errors.full_messages}, status: :unprocessable_entity
		end
	end

	def add_crispr_modification
	end

	private

	def set_biosample
		@biosample = Biosample.find(params[:id])
	end

	def biosample_params
		params.require(:biosample).permit(:owner_id, :prototype, :part_of_biosample_id, :control, :biosample_term_name_id, :submitter_comments, :lot_identifier, :vendor_product_identifier, :description, :passage_number, :date_biosample_taken, :encid, :donor_id,:vendor_id,:biosample_type_id,:name, :document_ids => [], crispr_construct_ids: [])
	end
end
