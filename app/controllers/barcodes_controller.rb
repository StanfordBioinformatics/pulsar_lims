class BarcodesController < ApplicationController
  before_action :set_barcode, only: [:show, :edit, :update, :destroy]

  def index
    @barcodes = policy_scope(Barcode.order(:sequence))
	end

  def show
		authorize @barcode
  end

  def new
		authorize Barcode
    @barcode = Barcode.new
  end

  def edit
		authorize @barcode
  end

  def create
		authorize Barcode
    @barcode = Barcode.new(barcode_params)
		@barcode.user = current_user

    respond_to do |format|
      if @barcode.save
        format.html { redirect_to @barcode, notice: 'Barcode was successfully created.' }
        format.json { render json: @barcode, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @barcode

    respond_to do |format|
      if @barcode.update(barcode_params)
        format.html { redirect_to @barcode, notice: 'Barcode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @barcode
    @barcode.destroy
    respond_to do |format|
      format.html { redirect_to barcodes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barcode
      @barcode = Barcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def barcode_params
      params.require(:barcode).permit(:user_id, :index_number, :sequencing_library_prep_kit_id, :name, :sequence)
    end
end
