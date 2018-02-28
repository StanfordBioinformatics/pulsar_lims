class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    @addresses = policy_scope(Address).order("lower(city)").page params[:page]
  end

  def show
		authorize @address
  end

  def new
		authorize Address
    @address = Address.new
  end

  def edit
		authorize @address
  end

  def create
    @address = Address.new(address_params)
		authorize @address
		@address.user = current_user

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @address
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @address
    ddestroy(@address,addresses_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = set_record(controller_name,params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:name,:street,:city,:state,:postal_code,:country)
    end
end
