class TreatmentsController < ApplicationController
  before_action :set_treatment, only: [:show, :edit, :update, :destroy]

  def select_options                                                                                   
    #Called via ajax.                                        
    #Typically called when the user selects the refresh icon in any form that has a treatments selection.
    @records = Treatment.all
    render "application_partials/select_options", layout: false
  end 

  def index
    @records = policy_scope(Treatment).page params[:page]
  end

  def show
    authorize @treatment
  end

  def new
    authorize Treatment
    @treatment = Treatment.new
  end

  def edit
    authorize @treatment
  end

  def create
    authorize Treatment
    @treatment = Treatment.new(treatment_params)
    @treatment.user = current_user

    respond_to do |format|
      if @treatment.save
        format.html { redirect_to @treatment, notice: 'Treatment was successfully created.' }
        format.json { render json: @treatment, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @treatment
    respond_to do |format|
      if @treatment.update(treatment_params)
        format.html { redirect_to @treatment, notice: 'Treatment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @treatment
    ddestroy(@treatment,treatments_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment
      @treatment = Treatment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_params
      params.require(:treatment).permit(:upstream_identifier, :treatment_term_name_id, :name, :description, :treatment_type, :concentration, :concentration_unit_id, :duration, :duration_units, :temperature, :document_ids => [], :treatment_ids => [])
    end
end
