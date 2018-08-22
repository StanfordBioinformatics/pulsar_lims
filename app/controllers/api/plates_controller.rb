class Api::PlatesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/plates/3
  before_action :set_plate, only: [:show, :update, :destroy]

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
    @plates = policy_scope(Plate).order("lower(name)")
    render json: @plates
  end

  def show
    authorize @plate
    render json: @plate
  end

  def create
    @plate = Plate.new(plate_params)
    @plate.user = @current_user
    authorize @plate
    if @plate.save
      render json: @plate, status: :created
    else
      render json: { errors: @plate.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @plate
    if @plate.update(plate_params)
      render json: @plate, status: 200
    else
      render json: { errors: @plate.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@plate)
  end

  private

  def set_plate
    @plate = Plate.find(params[:id])
  end

  def plate_params
    params.require(:plate).permit(
        :dimensions,                                                                                   
        :name,                                                                                         
        :notes,                                                                                        
        :single_cell_sorting_id,                                                                       
        :starting_biosample_id,                                                                        
        :vendor_id,                                                                                    
        :vendor_product_identifier,                                                                    
        antibody_ids: []
    )
  end
end
