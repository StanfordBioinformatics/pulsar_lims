class GelImagesController < ApplicationController
  before_action :set_gel_image, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def index
    super
  end

  def show
    authorize @gel_image
  end

  def new
    authorize GelImage
    @gel_image = GelImage.new
  end

  def edit
    authorize @gel_image
  end

  def create
    authorize GelImage
    @gel_image = GelImage.new(gel_image_params)
    @gel_image.user = current_user 

    respond_to do |format|
      if @gel_image.save
        format.html { redirect_to @gel_image, notice: 'Gel image was successfully created.' }
        format.json { render json: @gel_image, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @gel_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @gel_image
    respond_to do |format|
      if @gel_image.update(gel_image_params)
        format.html { redirect_to @gel_image, notice: 'Gel image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gel_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@gel_image, redirect_path_success: gel_images_path)
  end

  private
    def set_s3_direct_post                                                                             
      @s3_direct_post = S3_BUCKET.presigned_post(key: "images/gels/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
      #From the AWS docs, regarding the 201 here: If the value is set to 201, Amazon S3 returns an XML document with a 201 status code.
      #If we don't set the acl, then the file is not readable by others.                               
      #Also using #{SecureRandom.uuid} so that users don't overwrite an existing file with the same name.
    end  

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
