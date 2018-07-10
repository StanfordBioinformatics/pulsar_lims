class CloningVectorsController < ApplicationController
  before_action :set_cloning_vector, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

  def select_options                                                                                   
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a cloning_vectors input
    @records = CloningVector.all
    render "application_partials/select_options", layout: false
  end

  def index
    super
  end

  def show
    authorize @cloning_vector
  end

  def new
    authorize CloningVector
    @cloning_vector = CloningVector.new
  end

  def edit
    authorize @cloning_vector
  end

  def create
    authorize CloningVector
    @cloning_vector = CloningVector.new(cloning_vector_params)
  
    @cloning_vector.user = current_user  

    respond_to do |format|
      if @cloning_vector.save
        format.html { redirect_to @cloning_vector, notice: 'Cloning vector was successfully created.' }
        format.json { render json: @cloning_vector, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @cloning_vector.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @cloning_vector
    respond_to do |format|
      if @cloning_vector.update(cloning_vector_params)
        format.html { redirect_to @cloning_vector, notice: 'Cloning vector was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cloning_vector.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@cloning_vector, cloning_vectors_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cloning_vector
      @cloning_vector = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cloning_vector_params
      params.require(:cloning_vector).permit(
        :description, 
        :map, 
        :name, 
        :notes, 
        :product_url,
        :vendor_id, 
        :vendor_product_identifier
      )
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "images/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
      #From the AWS docs, regarding the 201 here: If the value is set to 201, Amazon S3 returns an XML document with a 201 status code.
      #If we don't set the acl, then the file is not readable by others.
      #Also using #{SecureRandom.uuid} so that users don't overwrite an existing file with the same name. 
    end 
end
