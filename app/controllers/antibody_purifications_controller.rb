class AntibodyPurificationsController < ApplicationController
  before_action :set_antibody_purification, only: [:show, :edit, :update, :destroy]

  def select_options                                                                                   
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a antibody_purifications selection.
    @records = AntibodyPurification.all
    render "application_partials/select_options", layout: false
  end 

  def index
    super
  end

  def show
    authorize @antibody_purification
  end

  def new
    authorize AntibodyPurification
    @antibody_purification = AntibodyPurification.new
  end

  def edit
    authorize @antibody_purification
  end

  def create
    @antibody_purification = AntibodyPurification.new(antibody_purification_params)
    authorize @antibody_purification
    @antibody_purification.user = current_user

    respond_to do |format|
      if @antibody_purification.save
        format.html { redirect_to @antibody_purification, notice: 'Antibody purification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @antibody_purification }
      else
        format.html { render action: 'new' }
        format.json { render json: @antibody_purification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @antibody_purification
    respond_to do |format|
      if @antibody_purification.update(antibody_purification_params)
        format.html { redirect_to @antibody_purification, notice: 'Antibody purification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @antibody_purification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@antibody_purification, antibody_purifications_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_antibody_purification
      @antibody_purification = set_record(controller_name,params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def antibody_purification_params
      params.require(:antibody_purification).permit(
        :name,
        :notes
      )
    end
end
