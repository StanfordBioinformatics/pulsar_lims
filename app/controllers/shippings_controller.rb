class ShippingsController < ApplicationController
  before_action :set_shipping, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @shipping
  end

  def new
    authorize Shipping
    @shipping = Shipping.new
  end

  def edit
    authorize @shipping
  end

  def create
    authorize Shipping
    @shipping = Shipping.new(shipping_params)
    @shipping.user = current_user

    redirect = @shipping
    if @shipping.biosample.present?
      redirect = @shipping.biosample
    end

    respond_to do |format|
      if @shipping.save
        format.html { redirect_to redirect, notice: 'Shipping was successfully created.' }
        format.json { render json: @shipping, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @shipping.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @shipping
    redirect = @shipping
    if @shipping.biosample.present?
      redirect = @shipping.biosample
    end
    respond_to do |format|
      if @shipping.update(shipping_params)
        format.html { redirect_to redirect, notice: 'Shipping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shipping.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@shipping, redirect_path_success: shippings_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipping
      @shipping = Shipping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
