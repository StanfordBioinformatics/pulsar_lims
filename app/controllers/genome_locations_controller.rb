class GenomeLocationsController < ApplicationController
  before_action :set_genome_location, only: [:show, :edit, :update, :destroy]

  def index
    @genome_locations = policy_scope(GenomeLocation).all
  end

  def show
		authorize $genome_location
  end

  def new
		authorize GenomeLocation
    @genome_location = GenomeLocation.new
  end

  def edit
		authorize $genome_location
  end

  def create
		authorize GenomeLocation
    @genome_location = GenomeLocation.new(genome_location_params)
		@genome_location.user = current_user

    respond_to do |format|
      if @genome_location.save
        format.html { redirect_to @genome_location, notice: 'Genome location was successfully created.' }
        format.json { render json: @genome_location, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @genome_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize $genome_location
    respond_to do |format|
      if @genome_location.update(genome_location_params)
        format.html { redirect_to @genome_location, notice: 'Genome location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @genome_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize $genome_location
		ddestroy(@genome_location,genome_locations_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_genome_location
      @genome_location = GenomeLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def genome_location_params
      params.require(:genome_location).permit(:chromosome_id, :start, :end)
    end
end
