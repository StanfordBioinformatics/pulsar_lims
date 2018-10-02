class Api::SequencingCentersController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/sequencing_centers/3
  before_action :set_sequencing_center, only: [:show, :update, :destroy]

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
    @sequencing_centers = policy_scope(SequencingCenter).order("lower(name)")
    render json: @sequencing_centers
  end

  def show
    authorize @sequencing_center
    render json: @sequencing_center
  end

  def create
    @sequencing_center = SequencingCenter.new(sequencing_center_params)
    @sequencing_center.user = @current_user
    authorize @sequencing_center
    if @sequencing_center.save
      render json: @sequencing_center, status: :created
    else
      render json: { errors: @sequencing_center.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @sequencing_center
    if @sequencing_center.update(sequencing_center_params)
      render json: @sequencing_center, status: 200
    else
      render json: { errors: @sequencing_center.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@sequencing_center)
  end

  private

  def set_sequencing_center
    @sequencing_center = SequencingCenter.find(params[:id])
  end

  def sequencing_center_params
    params.require(:sequencing_center).permit(
      :address,                                                                                      
      :name,                                                                                         
      :notes,                                                                                        
      :url 
    )
  end
end
