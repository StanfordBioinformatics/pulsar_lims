class Api::GelsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/gels/3
  before_action :set_gel, only: [:show, :update, :destroy]

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
    @gels = policy_scope(Gel).order("lower(name)")
    render json: @gels
  end

  def show
    authorize @gel
    render json: @gel
  end

  def create
    @gel = Gel.new(gel_params)
    @gel.user = @current_user
    authorize @gel
    if @gel.save
      render json: @gel, status: :created
    else
      render json: { errors: @gel.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @gel
    if @gel.update(gel_params)
      render json: @gel, status: 200
    else
      render json: { errors: @gel.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@gel)
  end

  private

  def set_gel
    @gel = Gel.find(params[:id])
  end

  def gel_params
    params.require(:gel).permit(
      :caption,                                                                                      
      :immunoblot_id,                                                                                
      :notes,                                                                                        
      :percentage,                                                                                   
      :run_date,                                                                                     
      :voltage,                                                                                      
      gel_image_ids: [],
      pcr_ids: []
    )
  end
end
