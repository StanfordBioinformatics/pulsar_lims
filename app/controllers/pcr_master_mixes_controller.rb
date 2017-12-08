class PcrMasterMixesController < ApplicationController
  before_action :set_pcr_master_mix, only: [:show, :edit, :update, :destroy]

  def index
    @pcr_master_mixes = policy_scope(PcrMasterMix).order("lower(name)")
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
    @pcr_master_mix.destroy
    respond_to do |format|
      format.html { redirect_to pcr_master_mixes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcr_master_mix
      @pcr_master_mix = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pcr_master_mix_params
      params.require(:pcr_master_mix).permit(:lot_identifier, :name, :vendor_id, :vendor_product_identifier, :vendor_product_url)
    end
end
