class AgaroseGelsController < ApplicationController
  before_action :set_agarose_gel, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @agarose_gel
  end

  def new
    authorize AgaroseGel
    @agarose_gel = AgaroseGel.new
  end

  def edit
    authorize @agarose_gel
  end

  def create
    authorize AgaroseGel
    @agarose_gel = AgaroseGel.new(agarose_gel_params)
    @agarose_gel.user = current_user

    respond_to do |format|
      if @agarose_gel.save
        format.html { redirect_to @agarose_gel, notice: 'Agarose gel was successfully created.' }
        format.json { render json: @agarose_gel, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @agarose_gel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @agarose_gel
    respond_to do |format|
      if @agarose_gel.update(agarose_gel_params)
        format.html { redirect_to @agarose_gel, notice: 'Agarose gel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @agarose_gel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@agarose_gel, redirect_path_success: agarose_gels_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agarose_gel
      @agarose_gel = AgaroseGel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agarose_gel_params
      params.require(:agarose_gel).permit(
        :notes,
        :percent_agarose, 
        :run_date,
        :voltage)
    end
end
