class AntibodyPurificationsController < ApplicationController
  before_action :set_antibody_purification, only: [:show, :edit, :update, :destroy]

  # GET /antibody_purifications
  # GET /antibody_purifications.json
  def index
    @antibody_purifications = AntibodyPurification.all
  end

  # GET /antibody_purifications/1
  # GET /antibody_purifications/1.json
  def show
  end

  # GET /antibody_purifications/new
  def new
    @antibody_purification = AntibodyPurification.new
  end

  # GET /antibody_purifications/1/edit
  def edit
  end

  # POST /antibody_purifications
  # POST /antibody_purifications.json
  def create
    @antibody_purification = AntibodyPurification.new(antibody_purification_params)

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

  # PATCH/PUT /antibody_purifications/1
  # PATCH/PUT /antibody_purifications/1.json
  def update
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

  # DELETE /antibody_purifications/1
  # DELETE /antibody_purifications/1.json
  def destroy
    @antibody_purification.destroy
    respond_to do |format|
      format.html { redirect_to antibody_purifications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_antibody_purification
      @antibody_purification = AntibodyPurification.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The antibody purification you were looking for could not be found."
      redirect_to antibody_purifications_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def antibody_purification_params
      params.require(:antibody_purification).permit(:name)
    end
end
