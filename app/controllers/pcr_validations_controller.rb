class PcrValidationsController < ApplicationController
  before_action :set_pcr_validation, only: [:show, :edit, :update, :destroy]

  def index
    @pcr_validations = policy_scope(PcrValidation)
  end

  def show
		authorize @pcr_validation
  end

  def new
		authorize PcrValidation
    @pcr_validation = PcrValidation.new
  end

  def edit
		authorize @pcr_validation
  end

  def create
		authorize PcrValidation
    @pcr_validation = PcrValidation.new(pcr_validation_params)
		@pcr_validation.user = current_user

    respond_to do |format|
      if @pcr_validation.save
        format.html { redirect_to @pcr_validation, notice: 'Pcr validation was successfully created.' }
        format.json { render json: @pcr_validation, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @pcr_validation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @pcr_validation
    respond_to do |format|
      if @pcr_validation.update(pcr_validation_params)
        format.html { redirect_to @pcr_validation, notice: 'Pcr validation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pcr_validation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @pcr_validation
    @pcr_validation.destroy
    respond_to do |format|
      format.html { redirect_to pcr_validations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pcr_validation
      @pcr_validation = PcrValidation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pcr_validation_params
      params.require(:pcr_validation).permit(:description, :pcr_master_mix_id, :forward_primer, :reverse_primer, :amplicon_size, :annealing_temperature, :extension_time, :num_cycles, :crispr_modification_id, :success)
    end
end
