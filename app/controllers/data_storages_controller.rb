class DataStoragesController < ApplicationController
  before_action :set_data_storage, only: [:show, :edit, :update, :destroy, :get_base_path]
	skip_after_action :verify_authorized, only: [:customize_for_data_storage_provider, :get_base_path]

	def get_base_path
    render text: @data_storage.folder_base_path
	end

	def customize_for_data_storage_provider
		provider_id = params[:data_storage_provider_id]
		provider = DataStorageProvider.find(provider_id)
		if provider.bucket_storage?
			render text: "bucket"
		else
			render text: "other"
		end
	end

  def index
		@records = policy_scope(DataStorage).page params[:page]
  end

  def show
		authorize @data_storage
		@bucketed = @data_storage.bucketed?
  end

  def new
		authorize DataStorage
    @data_storage = DataStorage.new
  end

  def edit
		authorize @data_storage
  end

  def create
		authorize DataStorage
    @data_storage = DataStorage.new(data_storage_params)
		@data_storage.user = current_user

    respond_to do |format|
      if @data_storage.save
        format.html { redirect_to @data_storage, notice: 'Data storage was successfully created.' }
        format.json { render json: @data_storage, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @data_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @data_storage
    respond_to do |format|
      if @data_storage.update(data_storage_params)
        format.html { redirect_to @data_storage, notice: 'Data storage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @data_storage.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @data_storage
    @data_storage.destroy
    respond_to do |format|
      format.html { redirect_to data_storages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_storage
      @data_storage = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    def data_storage_params
      params.require(:data_storage).permit(:data_storage_provider_id,:name, :bucket, :project_identifier, :folder_base_path)
    end
end
