class BatchItemsController < ApplicationController
  before_action :set_batch_item, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @batch_item
  end

  def new
    authorize BatchItem
    @batch_item = BatchItem.new
  end

  def edit
    authorize @batch_item
  end

  def create
    authorize BatchItem
    @batch_item = BatchItem.new(batch_item_params)
    @batch_item.user = current_user

    respond_to do |format|
      if @batch_item.save
        format.html { redirect_to @batch_item, notice: 'Batch item was successfully created.' }
        format.json { render json: @batch_item, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @batch_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @batch_item
    respond_to do |format|
      if @batch_item.update(batch_item_params)
        format.html { redirect_to @batch_item, notice: 'Batch item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @batch_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@batch_item, redirect_path_success: batch_items_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch_item
      @batch_item = BatchItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def batch_item_params
      params.require(:batch_item).permit(
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
      )
    end
end
