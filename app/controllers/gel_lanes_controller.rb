class GelLanesController < ApplicationController
  before_action :set_gel_lane, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @gel_lane
  end

  def new
    authorize GelLane
    @gel_lane = GelLane.new
  end

  def edit
    authorize @gel_lane
  end

  def create
    authorize GelLane
    @gel_lane = GelLane.new(gel_lane_params)
    @gel_lane.user = current_user

    respond_to do |format|
      if @gel_lane.save
        format.html { redirect_to @gel_lane, notice: 'Gel lane was successfully created.' }
        format.json { render json: @gel_lane, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @gel_lane.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @gel_lane
    respond_to do |format|
      if @gel_lane.update(gel_lane_params)
        format.html { redirect_to @gel_lane, notice: 'Gel lane was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gel_lane.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@gel_lane, redirect_path_success: gel_lanes_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gel_lane
      @gel_lane = GelLane.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gel_lane_params
      params.require(:gel_lane).permit(
          :actual_product_size, 
          :gel_id, 
          :biosample_id,
          :expected_product_size, 
          :lane_number, 
          :low_target_band_intensity,
          :needs_mass_spec,
          :sample_concentration,
          :sample_concentration_units_id,
          :sample_volume,
          :notes,
          :pass, 
          :submitter_comments
      )
    end
end
