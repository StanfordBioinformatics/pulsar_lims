class Api::ShippingsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/shippings/3
  before_action :set_shipping, only: [:show, :update, :destroy]

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
    @shippings = policy_scope(Shipping).order("lower(name)")
    render json: @shippings
  end

  def show
    authorize @shipping
    render json: @shipping
  end

  def create
    @shipping = Shipping.new(shipping_params)
    @shipping.user = @current_user
    authorize @shipping
    if @shipping.save
      render json: @shipping, status: :created
    else
      render json: { errors: @shipping.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @shipping
    if @shipping.update(shipping_params)
      render json: @shipping, status: 200
    else
      render json: { errors: @shipping.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@shipping)
  end

  private

  def set_shipping
    @shipping = Shipping.find(params[:id])
  end

  def shipping_params
    params.require(:shipping).permit(
        :biosample_id,                                                                                 
        :carrier,                                                                                      
        :date_shipped,                                                                                 
        :from_id,                                                                                      
        :received,                                                                                     
        :to_id,                                                                                        
        :tracking_code
    )
  end
end
