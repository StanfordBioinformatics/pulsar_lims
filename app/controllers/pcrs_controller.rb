class PcrsController < ApplicationController
  before_action :set_pcr, only: [:show, :edit, :update, :destroy]

  def index
    @pcrs = policy_scope(Pcr)
  end

  def show
		authorize @pcr
  end

  def new
		authorize Pcr
    @pcr = Pcr.new
  end

  def edit
		authorize @pcr
  end

  def create
		authorize Pcr
    @pcr = Pcr.new(pcr_params)
		@pcr.user = current_user

    respond_to do |format|
      if @pcr.save
        format.html { redirect_to @pcr, notice: 'Pcr was successfully created.' }
        format.json { render json: @pcr, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @pcr.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @pcr
    respond_to do |format|
      if @pcr.update(pcr_params)
        format.html { redirect_to @pcr, notice: 'Pcr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pcr.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @pcr
    @pcr.destroy
    respond_to do |format|
      format.html { redirect_to pcrs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcr
      @pcr = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pcr_params
      params.require(:pcr).permit(:description, :pcr_master_mix_id, :forward_primer, :reverse_primer, :amplicon_size, :annealing_temperature, :extension_time, :num_cycles, :crispr_modification_id, :success)
    end
end
