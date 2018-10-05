class ChipBatchesController < ApplicationController
  before_action :set_chip_batch, only: [:show, :edit, :update, :destroy, :add_chip_batch_item, :create_or_update_chip_batch_row]
  skip_after_action :verify_authorized, only: [:add_chip_batch_item, :create_or_update_chip_batch_row]

  def add_chip_batch_item
    # Called in /views/chip_batches/show.html.erb via AJAX to add a new row for entering a
    # ChipBatchItem.
    @chip_batch_item = @chip_batch.chip_batch_items.build()
    render partial: "chip_batch/add_chip_batch_item", layout: false
  end

  def create_or_update_chip_batch_item
    item_params = chip_batch_params[:chip_batch_items_attributes]["0"] # Subset the dict with only key being 0.
    if item_params[:id].present?
      # Then do an update
      @chip_batch_item = ChipBatchItem.find(item_params[:id])
      @chip_batch_item.update(item_params)
    else
      # Create it
      payload = item_params
      payload.update({user_id: current_user.id})
      @chip_batch_item = ChipBatchItem.create(payload)
    end
    render partial: "chip_batches/add_chip_batch_item", layout: false
  end

  def remove_chip_batch_item
    item_id = params[:chip_batch_item_id]
    # May be that the user never saved the chip_batch_item (row) and just wants to remove it.
    if item_id.present?
      @chip_batch_item = ChipBatchItem.find(item_id)
      @chip_batch_item.destroy!
    end
    render json: {}, status: :no_content
  end

  def index
    super
  end

  def show
    authorize @chip_batch
  end

  def new
    authorize ChipBatch
  end

  def edit
    authorize @chip_batch
  end

  def create
    authorize ChipBatch
    @chip_batch = ChipBatch.new(chip_batch_params)
    @chip_batch.user = current_user

    respond_to do |format|
      if @chip_batch.save
        format.html { redirect_to @chip_batch, notice: 'Chip batch was successfully created.' }
        format.json { render json: @chip_batch, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @chip_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @chip_batch
    respond_to do |format|
      if @chip_batch.update(chip_batch_params)
        format.html { redirect_to @chip_batch, notice: 'Chip batch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chip_batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@chip_batch, redirect_path_success: chip_batches_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chip_batch
      @chip_batch = ChipBatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chip_batch_params
      params.require(:chip_batch).permit(
        :analyst_id,
        :chip_batch_item_ids,
        :crosslinking_method,
        :date,
        :chip_batch_items_attributes [
          :id,
          :biosample_id,
          :chip_batch_id,
          :concentration,
          :concentration_unit_id,
          :notes
        ]
      )
    end
end
