class Api::ChipBatchItemsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/chip_batch_items/3
  before_action :set_chip_batch_item, only: [:show, :update, :destroy]

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
    @chip_batch_items = policy_scope(ChipBatchItem).order("lower(name)")
    render json: @chip_batch_items
  end

  def show
    authorize @chip_batch_item
    render json: @chip_batch_item
  end

  def create
    @chip_batch_item = ChipBatchItem.new(chip_batch_item_params)
    @chip_batch_item.user = @current_user
    authorize @chip_batch_item
    if @chip_batch_item.save
      render json: @chip_batch_item, status: :created
    else
      render json: { errors: @chip_batch_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @chip_batch_item
    if @chip_batch_item.update(chip_batch_item_params)
      render json: @chip_batch_item, status: 200
    else
      render json: { errors: @chip_batch_item.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@chip_batch_item)
  end

  private

  def set_chip_batch_item
    @chip_batch_item = ChipBatchItem.find(params[:id])
  end

  def chip_batch_item_params
    params.require(:chip_batch_item).permit(
        :biosample_id,
        :chip_batch_id,
        :concentration,
        :concentration_unit_id,
        :notes
    )
  end
end
