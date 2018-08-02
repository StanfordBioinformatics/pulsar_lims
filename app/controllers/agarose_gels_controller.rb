class AgaroseGelsController < ApplicationController
  before_action :set_agarose_gel, only: [:show, :edit, :update, :destroy, :add_lane, :create_or_update_gel_lane, :remove_gel_lane]
  skip_after_action :verify_authorized, only: [:add_lane, :create_or_update_gel_lane, :remove_gel_lane]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def add_lane
    # Called in /views/agarose_gels/show.html.erb via AJAX to add a new row for entering a 
    # GelLane.
    @gel_lane = @agarose_gel.gel_lanes.build()
    flash[:redirect] = "show"
    render partial: "agarose_gels/add_lane", layout: false
  end

  def create_or_update_gel_lane
    gel_lane_params = agarose_gel_params[:gel_lanes_attributes]["0"] # Index the dict with only key being 0.
    if gel_lane_params[:id].present?
      # Then do an update
      @gel_lane = GelLane.find(gel_lane_params[:id])
      @gel_lane.update(gel_lane_params)
    else
      # Create it
      payload = gel_lane_params
      payload.update({user_id: current_user.id})
      @gel_lane = GelLane.create(payload)
    end
    render partial: "agarose_gels/add_lane", layout: false
  end

  def remove_gel_lane 
    gel_lane_id = params[:gel_lane_id]
    # May be that the user never saved the gel_lane in the form and just wants to remove it. 
    if gel_lane_id.present?
      @gel_lane = GelLane.find(gel_lane_id)
      @gel_lane.destroy!
    end
    render json: {}, status: :no_content
  end

  def index
    super
  end

  def show
    authorize @agarose_gel
  end

  def new
    authorize AgaroseGel
    @agarose_gel = AgaroseGel.new
  end

  def edit
    authorize @agarose_gel
  end

  def create
    authorize AgaroseGel
    @agarose_gel = AgaroseGel.new(agarose_gel_params)
    @agarose_gel.user = current_user

    respond_to do |format|
      if @agarose_gel.save
        format.html { redirect_to @agarose_gel, notice: 'Agarose gel was successfully created.' }
        format.json { render json: @agarose_gel, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @agarose_gel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @agarose_gel
    respond_to do |format|
      if @agarose_gel.update(agarose_gel_params)
        format.html { redirect_to @agarose_gel, notice: 'Agarose gel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @agarose_gel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@agarose_gel, redirect_path_success: agarose_gels_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agarose_gel
      @agarose_gel = AgaroseGel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agarose_gel_params
      params.require(:agarose_gel).permit(
        :caption,
        :gel_image,
        :notes,
        :percent_agarose, 
        :run_date,
        :voltage,
        gel_lanes_attributes:  [
          :id,
          :actual_product_size,                                                                        
          :agarose_gel_id,                                                                             
          :expected_product_size,                                                                      
          :lane_number,                                                                                
          :sample_concentration,                                                                       
          :sample_concentration_units_id,                                                              
          :sample_volume,                                                                              
          :notes,                                                                                      
          :pass,                                                                                       
          :submitter_comments  
        ])
    end

    def set_s3_direct_post                                                                             
      @s3_direct_post = S3_BUCKET.presigned_post(key: "images/gels/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
      #From the AWS docs, regarding the 201 here: If the value is set to 201, Amazon S3 returns an XML document with a 201 status code.
      #If we don't set the acl, then the file is not readable by others.                               
      #Also using #{SecureRandom.uuid} so that users don't overwrite an existing file with the same name.
    end
end
