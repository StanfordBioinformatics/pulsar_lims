class PlatesController < ApplicationController
	include PlatesConcern #gives me add_barcodes_matrix_input()
  before_action :set_plate, only: [:show, :edit, :update, :destroy, :show_barcodes]
	 skip_after_action :verify_authorized, only: [:show_barcodes]

	def show_barcodes
		if params[:checked] == "true"
			@show_barcodes = 1
		end
		render partial: "plate", layout: false
	end	

  def index
    super(Plate)
  end

  def show
		authorize @plate
  end

  #def new
		#authorize Plate
    #@plate = Plate.new
  #end

  def edit
		authorize @plate
  end

  def create
		authorize Plate
    @plate = Plate.new(plate_params)

		@plate.user = current_user
    respond_to do |format|
      if @plate.save
        format.html { redirect_to @plate, notice: 'Plate was successfully created.' }
        format.json { render json: @plate, status: :created }
      else
        format.html { render action: 'new', alert: "uh-oh" }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @plate
    barcode_ids_param = :add_barcodes

    begin 
      if plate_params[barcode_ids_param].present?
        @plate = add_barcodes_matrix_input(plate=@plate,barcodes=plate_params[barcode_ids_param])
      end 
    #rescue Exceptions::BarcodeNotFoundError, Exceptions::TooManyRowsError, Exceptions::TooManyColumnsError, Exceptions::WellNotFoundError, Exceptions::WellAndPlateMismatchError, Exceptions::WellNotSavedError => err #any of these could be raised when calling add_barcodes(). And they all inherit from StandardError.
    rescue StandardError => err #any of these could be raised when calling add_barcodes().
      respond_to do |format|
        format.html { redirect_to @plate, alert: err.message }
      end 
      return
    end

    respond_to do |format|
      if @plate.update(plate_params)
        format.html { redirect_to @plate, notice: 'Plate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @plate
		ddestroy(@plate,plates_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plate
      @plate = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plate_params
      params.require(:plate).permit(
        :add_barcodes,
        :dimensions,
        :name,
        :notes,
        :single_cell_sorting_id, 
        :starting_biosample_id,
        :vendor_id,
        :vendor_product_identifier,
        antibody_ids: [])
    end
end
