class PcrsController < ApplicationController
  before_action :set_pcr, only: [:show, :edit, :update, :destroy, :add_gel, :select_gel]
  skip_after_action :verify_authorized, only: [:add_gel, :select_gel]

  def add_gel
    @gel = @pcr.build_gel
    @s3_direct_post = @gel.s3_direct_post()
  end

  def select_gel
    render layout: false
  end

  def index
    super
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
    ddestroy(@pcr.destroy, redirect_path_success: pcrs_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcr
      @pcr = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pcr_params
      params.require(:pcr).permit(
          :amplicon_size,
          :annealing_temperature,
          :crispr_modification_id,
          :description,
          :extension_time,
          :forward_primer,
          :name,
          :notes,
          :num_cycles,
          :pcr_master_mix_id,
          :reverse_primer,
          :success)
    end
end
