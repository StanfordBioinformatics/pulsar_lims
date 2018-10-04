class ChipBatchesController < ApplicationController
  before_action :set_chip_batch, only: [:show, :edit, :update, :destroy]

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
        :date
      )
    end
end
