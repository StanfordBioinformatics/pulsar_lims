class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy, :add_batch_item, :create_or_update_batch_item, :refresh_batch_item_row]
  skip_after_action :verify_authorized, only: [:add_batch_item, :create_or_update_batch_item, :remove_batch_item, :refresh_batch_item_row]

  def add_batch_item
    # Called in /views/batches/show.html.erb via AJAX to add a new row for entering a
    # BatchItem.
    @batch_item = @batch.batch_items.build()
    render partial: "batches/add_batch_item", layout: false
  end

  def create_or_update_batch_item
    item_params = batch_params[:batch_items_attributes]["0"] # Subset the dict with only key being 0.
    logger.debug(params)
    if item_params[:id].present?
      # Then do an update
      @batch_item = BatchItem.find(item_params[:id])
      @batch_item.update(item_params)
    else
      # Create it
      payload = item_params
      payload.update({user_id: current_user.id})
      @batch_item = BatchItem.create(payload)
    end
    render partial: "batches/add_batch_item", layout: false
  end

  def refresh_batch_item_row
    @batch_item = BatchItem.find(params[:batch_item_id])
    render partial: "batches/add_batch_item", layout: false
  end

  def remove_batch_item
    item_id = params[:batch_item_id]
    # May be that the user never saved the batch_item (row) and just wants to remove it.
    if item_id.present?
      @batch_item = BatchItem.find(item_id)
      @batch_item.destroy!
    end
    render json: {}, status: :no_content
  end

  def index
    super
  end

  def show
    authorize @batch
  end

  def new
    authorize Batch
    @batch = Batch.new 
  end

  def edit
    authorize @batch
  end

  def create
    authorize Batch
    @batch = Batch.new(batch_params)
    @batch.user = current_user

    respond_to do |format|
      if @batch.save
        format.html { redirect_to @batch, notice: 'Batch was successfully created.' }
        format.json { render json: @batch, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @batch
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to @batch, notice: 'Batch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@batch, redirect_path_success: batches_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def batch_params
      params.require(:batch).permit(
        :analyst_id,
        :batch_item_ids,
        :crosslinking_method,
        :date,
        :library_prototype_id,
        :notes,
        batch_items_attributes: [
          :antibody_id,
          :id,
          :biosample_id,
          :batch_id,
          :concentration,
          :concentration_unit_id,
          :library_id,
          :notes,
          library_attributes: [                                                                          
            :id,                                                                                         
            :antibody_id,                                                                                
            :barcode_id,                                                                                 
            :paired_barcode_id                                                                           
          ] 
        ]
      )
    end
end
