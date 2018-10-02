class Api::SequencingPlatformsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/sequencing_platforms/3
  before_action :set_sequencing_platform, only: [:show, :update, :destroy]

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
    @sequencing_platforms = policy_scope(SequencingPlatform).order("lower(name)")
    render json: @sequencing_platforms
  end

  def show
    authorize @sequencing_platform
    render json: @sequencing_platform
  end

  def create
    @sequencing_platform = SequencingPlatform.new(sequencing_platform_params)
    @sequencing_platform.user = @current_user
    authorize @sequencing_platform
    if @sequencing_platform.save
      render json: @sequencing_platform, status: :created
    else
      render json: { errors: @sequencing_platform.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @sequencing_platform
    if @sequencing_platform.update(sequencing_platform_params)
      render json: @sequencing_platform, status: 200
    else
      render json: { errors: @sequencing_platform.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@sequencing_platform)
  end

  private

  def set_sequencing_platform
    @sequencing_platform = SequencingPlatform.find(params[:id])
  end

  def sequencing_platform_params
    params.require(:sequencing_platform).permit(
      :name,
      :notes,
      :upstream_identifier
    )
  end
end
