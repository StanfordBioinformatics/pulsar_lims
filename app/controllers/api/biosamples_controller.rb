class Api::BiosamplesController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosamples/3
	before_action :set_biosample, only: [:show]

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

	private

	def set_biosample
		@biosample = Biosample.find(params[:id])
	end

	def biosample_params
		params.require(:biosample).permit(:owner_id, :prototype, :parent_biosample_id, :control, :biosample_term_name_id, :submitter_comments, :lot_identifier, :vendor_product_identifier, :description, :passage_number, :culture_harvest_date, :encid, :donor_id,:vendor_id,:biosample_type_id,:name, :document_ids => [], :crispr_attributes => [:user_id,:name, :donor_construct_id, genomic_integration_site_attributes: [:id, :chromosome_id, :start, :end], crispr_construct_ids: []])
end
