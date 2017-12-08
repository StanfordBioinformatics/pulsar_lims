class FileReferencesController < ApplicationController
  before_action :set_file_reference, only: [:show, :edit, :update, :destroy]

	def index
		@file_references = policy_scope(FileReference)
	end

  def show
		authorize @file_reference
  end

  def new
		authorize FileReference
    @file_reference = FileReference.new
  end

  def edit
		authorize @file_reference
  end

  def create
		authorize FileReference
    @file_reference = FileReference.new(file_reference_params)
		@file_reference.user = current_user

    respond_to do |format|
      if @file_reference.save
        format.html { redirect_to @file_reference, notice: 'File reference was successfully created.' }
        format.json { render json: @file_reference, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @file_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @file_reference
    respond_to do |format|
      if @file_reference.update(file_reference_params)
        format.html { redirect_to @file_reference, notice: 'File reference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @file_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @file_reference
    @file_reference.destroy
    respond_to do |format|
      format.html { redirect_to file_references_url }
      format.json { head :no_content }
    end
  end

  private
    def set_file_reference
      @file_reference = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    def file_reference_params
      params.require(:file_reference).permit(:data_file_type_id, :data_storage_id, :file_path, :fileid)
    end
end
