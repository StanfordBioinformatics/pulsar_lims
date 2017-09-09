class BarcodesController < ApplicationController
	before_action :set_sequencing_library_prep_kit
  before_action :set_barcode, only: [:show, :edit, :update, :destroy]

  def show
		authorize @barcode
  end

  def new
		authorize Barcode
    @barcode = @sequencing_library_prep_kit.barcodes.build
  end

  def edit
		authorize @barcode
  end

  def create
		authorize Barcode
    @barcode = @sequencing_library_prep_kit.barcodes.build(barcode_params)
		@barcode.user = current_user

    respond_to do |format|
      if @barcode.save
        format.html { redirect_to @sequencing_library_prep_kit, notice: 'Barcode was successfully created.' }
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
		ddestroy(@barcode,barcodes_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_library_prep_kit
      @sequencing_library_prep_kit = SequencingLibraryPrepKit.find(params[:sequencing_library_prep_kit_id])
    end 

    def set_barcode
      @barcode = Barcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def barcode_params
      params.require(:barcode).permit(:index_number, :sequencing_library_prep_kit_id, :name, :sequence)
    end
end
