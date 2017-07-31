class WellsController < ApplicationController
  before_action :set_plate
  before_action :set_well, only: [:show, :edit, :update]

  def show
		authorize @well
  end

  def edit
		authorize @well
  end

  def create
		authorize Well
    @well = Well.new(well_params)
		@well.user = current_user

    respond_to do |format|
      if @well.save
        format.html { redirect_to @well, notice: 'Well was successfully created.' }
        format.json { render json: @well, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @well.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @well
    respond_to do |format|
      if @well.update(well_params)
        format.html { redirect_to @plate, notice: 'Well was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @well.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
		def set_plate
			@plate = Plate.find(params[:plate_id])
		end

    def set_well
      @well = Well.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def well_params
      params.require(:well).permit(:fail, :comment)
    end
end
