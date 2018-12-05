class Api::SequencingResultsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/sequencing_results/3
  before_action :set_sequencing_result, only: [:show, :update, :destroy]

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
    @sequencing_results = policy_scope(SequencingResult).order("lower(name)")
    render json: @sequencing_results
  end

  def show
    authorize @sequencing_result
    render json: @sequencing_result
  end

  def create
    @sequencing_result = SequencingResult.new(sequencing_result_params)
    @sequencing_result.user = @current_user
    authorize @sequencing_result
    if @sequencing_result.save
      render json: @sequencing_result, status: :created
    else
      render json: { errors: @sequencing_result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @sequencing_result
    if @sequencing_result.update(sequencing_result_params)
      render json: @sequencing_result, status: 200
    else
      render json: { errors: @sequencing_result.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@sequencing_result)
  end

  private

  def set_sequencing_result
    @sequencing_result = SequencingResult.find(params[:id])
  end

  def sequencing_result_params
    params.require(:sequencing_result).permit(
        :comment,
        :is_control,
        :library_id,
        :merged_r1,
        :merged_r1,
        :notes,
        :pair_aligned_perc,
        :read1_aligned_perc,
        :read1_uri,
        :read1_upstream_identifier,
        :read1_count,
        :read2_aligned_perc,
        :read2_uri,
        :read2_upstream_identifier,
        :read2_count,
        :sequencing_run_id,
        :user_id
    )
  end
end
