class Api::BiosamplesController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosamples/3
	before_action :set_biosample, only: [:show, :update, :destroy, :add_crispr_modification]

  def find_by
    #find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

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
			render json: @biosample, status: 200
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
      params.require(:biosample).permit(
        :user_id,
        :biosample_term_name_id,
        :biosample_type_id,
        :control,
        :date_biosample_taken,
        :description,
        :donor_id,
        :lot_identifier,
        :name,
        :nih_institutional_certification,
        :owner_id,
        :part_of_biosample_id,
        :passage_number,
        :prototype,
        :starting_amount,
        :starting_amount_units,
        :submitter_comments,
        :tissue_preservation_method,
        :tube_label,
        :upstream_identifier,
        :vendor_id,
        :vendor_product_identifier,

        crispr_modification_attributes: [
          :user_id,
          :_destroy,
          :name,
          :donor_construct_id,
          crispr_constructs_attributes: [:id, :_destroy],
          crispr_construct_ids: [],
          genomic_integration_site_attributes: [
            :id,
            :chromosome_id,
            :end,
            :start
          ]
        ],
        documents_attributes: [:id, :_destroy],
        :document_ids => [],
        pooled_from_biosamples_attributes: [:id, :_destroy],
        :pooled_from_biosample_ids => [],
        treatments_attributes: [:id, :_destroy],
        :treatment_ids => []
    )
    end
end
