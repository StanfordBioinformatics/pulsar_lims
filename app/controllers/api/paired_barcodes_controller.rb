class Api::PairedBarcodesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/paired_barcodes/3
  before_action :set_paired_barcode, only: [:show, :update, :destroy]

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
    @paired_barcodes = policy_scope(PairedBarcode).order("lower(name)")
    render json: @paired_barcodes
  end

  def show
    authorize @paired_barcode
    render json: @paired_barcode
  end

  def create
    @paired_barcode = PairedBarcode.new(paired_barcode_params)
    @paired_barcode.user = @current_user
    authorize @paired_barcode
    if @paired_barcode.save
      render json: @paired_barcode, status: :created
    else
      render json: { errors: @paired_barcode.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @paired_barcode
    if @paired_barcode.update(paired_barcode_params)
      render json: @paired_barcode, status: 200
    else
      render json: { errors: @paired_barcode.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@paired_barcode)
  end

  private

  def set_paired_barcode
    @paired_barcode = PairedBarcode.find(params[:id])
  end

  def paired_barcode_params
    params.require(:paired_barcode).permit(
        :add_paired_barcodes,                                                                          
        :index1_id,                                                                                    
        :index2_id,
        :name,        
        :notes,                                                                                        
        :sequencing_library_prep_kit_id
    )
  end
end
