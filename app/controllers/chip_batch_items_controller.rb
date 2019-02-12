class ChipBatchItemsController < ApplicationController
  before_action :set_chip_batch_item, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @chip_batch_item
  end

  def new
    authorize ChipBatchItem
    @chip_batch_item = ChipBatchItem.new
  end

  def edit
    authorize @chip_batch_item
  end

  def create
    authorize ChipBatchItem
    @chip_batch_item = ChipBatchItem.new(chip_batch_item_params)
    @chip_batch_item.user = current_user

    respond_to do |format|
      if @chip_batch_item.save
        format.html { redirect_to @chip_batch_item, notice: 'Chip batch item was successfully created.' }
        format.json { render json: @chip_batch_item, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @chip_batch_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @chip_batch_item
    respond_to do |format|
      if @chip_batch_item.update(chip_batch_item_params)
        format.html { redirect_to @chip_batch_item, notice: 'Chip batch item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chip_batch_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@chip_batch_item, redirect_path_success: chip_batch_items_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chip_batch_item
      @chip_batch_item = ChipBatchItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chip_batch_item_params
      params.require(:chip_batch_item).permit(
        :biosample_id, 
        :chip_batch_id,
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
