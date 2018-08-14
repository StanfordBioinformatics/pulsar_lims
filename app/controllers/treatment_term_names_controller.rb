class TreatmentTermNamesController < ApplicationController
  before_action :set_treatment_term_name, only: [:show, :edit, :update, :destroy]

  def select_options                                                                                   
    #Called via ajax.                                                                                  
    #Typically called when the user selects the refresh icon in any form that has a treatment_term_names input.   
    @records = TreatmentTermName.all                                                                               
    render "application_partials/select_options", layout: false                                        
  end

  def index
    super
  end

  def show
    authorize @treatment_term_name
  end

  def new
    authorize TreatmentTermName
    @treatment_term_name = TreatmentTermName.new
  end

  def edit
    authorize @treatment_term_name
  end

  def create
    authorize TreatmentTermName
    @treatment_term_name = TreatmentTermName.new(treatment_term_name_params)
    @treatment_term_name.user = current_user

    respond_to do |format|
      if @treatment_term_name.save
        format.html { redirect_to @treatment_term_name, notice: 'Treatment term name was successfully created.' }
        format.json { render json: @treatment_term_name, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @treatment_term_name.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @treatment_term_name
    respond_to do |format|
      if @treatment_term_name.update(treatment_term_name_params)
        format.html { redirect_to @treatment_term_name, notice: 'Treatment term name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @treatment_term_name.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@treatment_term_name, redirect_path_success: treatment_term_names_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treatment_term_name
      @treatment_term_name = TreatmentTermName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treatment_term_name_params
      params.require(:treatment_term_name).permit(
        :accession, 
        :description,
        :name
      )
    end
end
