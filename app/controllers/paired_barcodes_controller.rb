class PairedBarcodesController < ApplicationController
  before_action :set_paired_barcode, only: [:show, :edit, :update, :destroy]

  def index
    @paired_barcodes = policy_scope(PairedBarcode).order("lower(name)")
  end

  def show
		authorize @paired_barcode
  end

  def new
		authorize PairedBarcode
    @paired_barcode = PairedBarcode.new
  end

  def edit
  end

  def create
		authorize PairedBarcode
    @paired_barcode = PairedBarcode.new(paired_barcode_params)
		@paired_barcode.user = current_user

    respond_to do |format|
      if @paired_barcode.save
        format.html { redirect_to @paired_barcode, notice: 'Paired barcode was successfully created.' }
        format.json { render json: @paired_barcode, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @paired_barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @paired_barcode
    respond_to do |format|
      if @paired_barcode.update(paired_barcode_params)
        format.html { redirect_to @paired_barcode, notice: 'Paired barcode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paired_barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @paired_barcode
    @paired_barcode.destroy
    respond_to do |format|
      format.html { redirect_to paired_barcodes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paired_barcode
      @paired_barcode = PairedBarcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paired_barcode_params
      params.require(:paired_barcode).permit(:name, :index1_id, :index2_id, :sequencing_library_prep_kit_id)
    end
end
