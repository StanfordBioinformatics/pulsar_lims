class Api::BatchItemsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/batch_items/3
  before_action :set_batch_item, only: [:show, :update, :destroy]

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
    @batch_items = policy_scope(BatchItem).order("lower(name)")
    render json: @batch_items
  end

  def show
    authorize @batch_item
    render json: @batch_item
  end

  def create
    @batch_item = BatchItem.new(batch_item_params)
    @batch_item.user = @current_user
    authorize @batch_item
    if @batch_item.save
      render json: @batch_item, status: :created
    else
      render json: { errors: @batch_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @batch_item
    if @batch_item.update(batch_item_params)
      render json: @batch_item, status: 200
    else
      render json: { errors: @batch_item.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@batch_item)
  end

  private

  def set_batch_item
    @batch_item = BatchItem.find(params[:id])
  end

  def batch_item_params
    params.require(:batch_item).permit(
        :antibody_id,
        :biosample_id,
        :batch_id,
        :concentration,
        :concentration_unit_id,
        :library_id,
        :notes
    )
  end
end
