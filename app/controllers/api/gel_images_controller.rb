class Api::GelImagesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/gel_images/3
  before_action :set_gel_image, only: [:show, :update, :destroy]

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
    @gel_images = policy_scope(GelImage).order("lower(name)")
    render json: @gel_images
  end

  def show
    authorize @gel_image
    render json: @gel_image
  end

  def create
    @gel_image = GelImage.new(gel_image_params)
    @gel_image.user = @current_user
    authorize @gel_image
    if @gel_image.save
      render json: @gel_image, status: :created
    else
      render json: { errors: @gel_image.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @gel_image
    if @gel_image.update(gel_image_params)
      render json: @gel_image, status: 200
    else
      render json: { errors: @gel_image.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@gel_image)
  end

  private

  def set_gel_image
    @gel_image = GelImage.find(params[:id])
  end

  def gel_image_params
    params.require(:gel_image).permit(
      :caption,                                                                                      
      :gel_id,                                                                                       
      :film_exposure_time,                                                                           
      :image 
    )
  end
end
