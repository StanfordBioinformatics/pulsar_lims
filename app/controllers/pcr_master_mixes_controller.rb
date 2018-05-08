class PcrMasterMixesController < ApplicationController
  before_action :set_pcr_master_mix, only: [:show, :edit, :update, :destroy]

  def select_options
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a pcr_master_mixes selection.
    @records = PcrMasterMix.all
    render "application_partials/select_options", layout: false
  end

  def index
    super(PcrMasterMix)
  end

  def show
		authorize @pcr_master_mix
  end

  def new
		authorize PcrMasterMix
    @pcr_master_mix = PcrMasterMix.new
  end

  def edit
		authorize @pcr_master_mix
  end

  def create
		authorize PcrMasterMix
    @pcr_master_mix = PcrMasterMix.new(pcr_master_mix_params)
		@pcr_master_mix.user = current_user

    respond_to do |format|
      if @pcr_master_mix.save
        format.html { redirect_to @pcr_master_mix, notice: 'pcr master mix was successfully created.' }
        format.json { render json: @pcr_master_mix, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @pcr_master_mix.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @pcr_master_mix
    respond_to do |format|
      if @pcr_master_mix.update(pcr_master_mix_params)
        format.html { redirect_to @pcr_master_mix, notice: 'pcr master mix was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pcr_master_mix.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @pcr_master_mix
    ddestroy(@pcr_master_mix, pcr_master_mixes_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcr_master_mix
      @pcr_master_mix = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pcr_master_mix_params
      params.require(:pcr_master_mix).permit(
        :lot_identifier, 
        :name, 
        :notes, 
        :vendor_id, 
        :vendor_product_identifier, 
        :vendor_product_url
      )
    end
end
