class Api::CrisprConstructsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/crispr_constructs/3
	before_action :set_crispr_construct, only: [:show]

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
    params.require(:crispr_construct).permit(
      :user_id,
      :addgene_id,
      :cloning_vector_id,
      :date_sent,
      :description,
      :ensembl_transcript,
      :guide_sequence,
      :name,
      :notes,
      :refseq_transcript,
      :sent_to,
      :target_id,
      :vendor_id,
      :vendor_product_identifier,
      construct_tags_attributes: [:id,:_destroy],
      :construct_tag_ids => [],
    )
	end
end
