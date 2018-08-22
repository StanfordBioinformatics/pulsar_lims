class Api::BarcodesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/barcodes/3
  before_action :set_barcode, only: [:show, :update, :destroy]

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
    @barcodes = policy_scope(Barcode).order("lower(name)")
    render json: @barcodes
  end

  def show
    authorize @barcode
    render json: @barcode
  end

  def create
    @barcode = Barcode.new(barcode_params)
    @barcode.user = @current_user
    authorize @barcode
    if @barcode.save
      render json: @barcode, status: :created
    else
      render json: { errors: @barcode.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @barcode
    if @barcode.update(barcode_params)
      render json: @barcode, status: 200
    else
      render json: { errors: @barcode.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@barcode)
  end

  private

  def set_barcode
    @barcode = Barcode.find(params[:id])
  end

  def barcode_params
    params.require(:barcode).permit(
        :index_number,                                                                                 
        :name,                                                                                         
        :notes,                                                                                        
        :sequence,                                                                                     
        :sequencing_library_prep_kit_id 
    )
  end
end
