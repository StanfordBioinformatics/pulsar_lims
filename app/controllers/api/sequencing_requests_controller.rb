class Api::SequencingRequestsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/sequencing_requests/3
  before_action :set_sequencing_request, only: [:show, :update, :destroy]

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
    @sequencing_requests = policy_scope(SequencingRequest).order("lower(name)")
    render json: @sequencing_requests
  end

  def show
    authorize @sequencing_request
    render json: @sequencing_request
  end

  def create
    @sequencing_request = SequencingRequest.new(sequencing_request_params)
    @sequencing_request.user = @current_user
    authorize @sequencing_request
    if @sequencing_request.save
      render json: @sequencing_request, status: :created
    else
      render json: { errors: @sequencing_request.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @sequencing_request
    if @sequencing_request.update(sequencing_request_params)
      render json: @sequencing_request, status: 200
    else
      render json: { errors: @sequencing_request.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@sequencing_request)
  end

  private

  def set_sequencing_request
    @sequencing_request = SequencingRequest.find(params[:id])
  end

  def sequencing_request_params
    params.require(:sequencing_request).permit(
        :average_size,
        :concentration,
        :concentration_instrument,
        :concentration_unit_id,
        :date_submitted,
        :name,
        :notes,
        :paired_end,
        :sample_sheet,
        :sequencing_center_id,
        :sequencing_platform_id,
        :submission_sheet,
        :submitted_by_id,
        :plate_ids => [],
        :library_ids => []
    )
  end
end
