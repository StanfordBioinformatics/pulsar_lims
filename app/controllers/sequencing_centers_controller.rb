class SequencingCentersController < ApplicationController
  before_action :set_sequencing_center, only: [:show, :edit, :update, :destroy]

  # GET /sequencing_centers
  # GET /sequencing_centers.json
  def index
    @sequencing_centers = policy_scope(SequencingCenter).order("lower(name)")
  end

  # GET /sequencing_centers/1
  # GET /sequencing_centers/1.json
  def show
		authorize @sequencing_center
  end

  # GET /sequencing_centers/new
  def new
    @sequencing_center = SequencingCenter.new
		authorize @sequencing_center
  end

  # GET /sequencing_centers/1/edit
  def edit
		authorize @sequencing_center
  end

  # POST /sequencing_centers
  # POST /sequencing_centers.json
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

  # PATCH/PUT /sequencing_centers/1
  # PATCH/PUT /sequencing_centers/1.json
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

  # DELETE /sequencing_centers/1
  # DELETE /sequencing_centers/1.json
  def destroy
		authorize @sequencing_center
    @sequencing_center.destroy
    respond_to do |format|
      format.html { redirect_to sequencing_centers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_center
      @sequencing_center = SequencingCenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_center_params
      params.require(:sequencing_center).permit(:name, :address)
    end
end
