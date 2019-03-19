class Api::GelLanesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/gel_lanes/3
  before_action :set_gel_lane, only: [:show, :update, :destroy]

  def find_by
    # find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

  def index
    @gel_lanes = policy_scope(GelLane).order("lower(name)")
    render json: @gel_lanes
  end

  def show
    authorize @gel_lane
    render json: @gel_lane
  end

  def create
    @gel_lane = GelLane.new(gel_lane_params)
    @gel_lane.user = @current_user
    authorize @gel_lane
    if @gel_lane.save
      render json: @gel_lane, status: :created
    else
      render json: { errors: @gel_lane.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @gel_lane
    if @gel_lane.update(gel_lane_params)
      render json: @gel_lane, status: 200
    else
      render json: { errors: @gel_lane.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@gel_lane)
  end

  private

  def set_gel_lane
    @gel_lane = GelLane.find(params[:id])
  end

  def gel_lane_params
    params.require(:gel_lane).permit(
      :gel_id,                                                                                     
      :biosample_id,                                                                               
      :expected_product_size,                                                                      
      :lane_number,                                                                                
      :low_target_band_intensity,                                                                  
      :needs_additional_pcr,
      :needs_mass_spec,                                                                            
      :sample_concentration,                                                                       
      :sample_concentration_units_id,                                                              
      :sample_volume,                                                                              
      :upstream_identifier,
      :notes,                                                                                      
      :pass,                                                                                       
      :submitter_comments 
    )
  end
end
