class Api::BatchsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/batches/3
  before_action :set_batch, only: [:show, :update, :destroy]

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
    @batches = policy_scope(Batch).order("lower(name)")
    render json: @batches
  end

  def show
    authorize @batch
    render json: @batch
  end

  def create
    @batch = Batch.new(batch_params)
    @batch.user = @current_user
    authorize @batch
    if @batch.save
      render json: @batch, status: :created
    else
      render json: { errors: @batch.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @batch
    if @batch.update(batch_params)
      render json: @batch, status: 200
    else
      render json: { errors: @batch.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@batch)
  end

  private

  def set_batch
    @batch = Batch.find(params[:id])
  end

  def batch_params
    params.require(:batch).permit(
        :analyst_id,
        :batch_item_ids,
        :batch_type,
        :crosslinking_method,
        :date,
        :library_prototype_id,
        :notes
    )
  end
end
