class Api::ChipBatchsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/chip_batchs/3
  before_action :set_chip_batch, only: [:show, :update, :destroy]

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
    @chip_batchs = policy_scope(ChipBatch).order("lower(name)")
    render json: @chip_batchs
  end

  def show
    authorize @chip_batch
    render json: @chip_batch
  end

  def create
    @chip_batch = ChipBatch.new(chip_batch_params)
    @chip_batch.user = @current_user
    authorize @chip_batch
    if @chip_batch.save
      render json: @chip_batch, status: :created
    else
      render json: { errors: @chip_batch.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @chip_batch
    if @chip_batch.update(chip_batch_params)
      render json: @chip_batch, status: 200
    else
      render json: { errors: @chip_batch.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@chip_batch)
  end

  private

  def set_chip_batch
    @chip_batch = ChipBatch.find(params[:id])
  end

  def chip_batch_params
    params.require(:chip_batch).permit(
        :analyst_id,
        :chip_batch_item_ids,
        :crosslinking_method,
        :date
    )
  end
end
