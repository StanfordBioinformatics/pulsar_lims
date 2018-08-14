class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def select_options                                                                                   
    #Called via ajax.                                                                                  
    #Typically called when the user selects the refresh icon in any form that has a vendors selection.   
    @records = Vendor.all                                                                               
    render "application_partials/select_options", layout: false
  end       

  def index
    super
  end

  def show
    authorize @vendor
  end

  def new
    authorize Vendor
    @vendor = Vendor.new
  end

  def edit
    authorize @vendor
  end

  def create
    @vendor = Vendor.new(vendor_params)
    authorize @vendor
    @vendor.user = current_user

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to @vendor, notice: 'Vendor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vendor }
      else
        format.html { render action: 'new' }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @vendor
    respond_to do |format|
      if @vendor.update(vendor_params)
        format.html { redirect_to @vendor, notice: 'Vendor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@vendor, redirect_path_success: vendors_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit(
        :description,
        :name, 
        :notes,
        :upstream_identifier, 
        :url
      )
    end
end
