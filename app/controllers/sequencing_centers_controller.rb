class SequencingCentersController < ApplicationController
  before_action :set_sequencing_center, only: [:show, :edit, :update, :destroy]

  def select_options
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a sequencing_centers selection.
    @records = SequencingCenter.all                                                                  
    render "application_partials/select_options", layout: false
  end

  def index
    @records = policy_scope(SequencingCenter).page params[:page]
  end

  def show
		authorize @sequencing_center
  end

  def new
    @sequencing_center = SequencingCenter.new
		authorize @sequencing_center
  end

  def edit
		authorize @sequencing_center
  end

  def create
    @sequencing_center = SequencingCenter.new(sequencing_center_params)
		authorize @sequencing_center
		@sequencing_center.user = current_user

    respond_to do |format|
      if @sequencing_center.save
        format.html { redirect_to @sequencing_center, notice: 'Sequencing center was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sequencing_center }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequencing_center.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @sequencing_center
    respond_to do |format|
      if @sequencing_center.update(sequencing_center_params)
        format.html { redirect_to @sequencing_center, notice: 'Sequencing center was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequencing_center.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @sequencing_center
		ddestroy(@sequencing_center,sequencing_centers_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_center
      @sequencing_center = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_center_params
      params.require(:sequencing_center).permit(:name, :address, :url)
    end
end
