class Api::BiosampleReplicatesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosample_replicates/3
  before_action :set_biosample_replicate, only: [:show, :update, :destroy]

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
    @biosample_replicates = policy_scope(BiosampleReplicate).order("lower(name)")
    render json: @biosample_replicates
  end

  def show
    authorize @biosample_replicate
    render json: @biosample_replicate
  end

  def create
    @biosample_replicate = BiosampleReplicate.new(biosample_replicate_params)
    @biosample_replicate.user = @current_user
    authorize @biosample_replicate
    if @biosample_replicate.save
      render json: @biosample_replicate, status: :created
    else
      render json: { errors: @biosample_replicate.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @biosample_replicate
    if @biosample_replicate.update(biosample_params)
      render json: @biosample_replicate, status: 200
    else
      render json: { errors: @biosample_replicate.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@biosample_replicate)
  end

  private

  def set_biosample_replicate
    @biosample_replicate = BiosampleReplicate.find(params[:id])
  end

  def biosample_replicate_params
    params.require(:biosample_replicate).permit(
        :biological_replicate_number,
        :biosample_id,
        :chipseq_experiment_id,
        :control,
        :notes,
        :technical_replicate_number,
        :upstream_identifier,
        :wild_type_input
    )
  end
end
