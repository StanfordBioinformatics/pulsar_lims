class DataStorageProvidersController < ApplicationController
  before_action :set_data_storage_provider, only: [:show, :edit, :update, :destroy]

  def index
    @data_storage_providers = policy_scope(DataStorageProvider).order("lower(name)")
  end

  def show
		authorize @data_storage_provider
  end

  def new
		authorize DataStorageProvider
    @data_storage_provider = DataStorageProvider.new
  end

  def edit
  end

  def create
		authorize DataStorageProvider
    @data_storage_provider = DataStorageProvider.new(data_storage_provider_params)
		@data_storage_provider.user = current_user

    respond_to do |format|
      if @data_storage_provider.save
        format.html { redirect_to @data_storage_provider, notice: 'Data storage provider was successfully created.' }
        format.json { render json: @data_storage_provider, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @data_storage_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @data_storage_provider
    respond_to do |format|
      if @data_storage_provider.update(data_storage_provider_params)
        format.html { redirect_to @data_storage_provider, notice: 'Data storage provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @data_storage_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @data_storage_provider
    @data_storage_provider.destroy
    respond_to do |format|
      format.html { redirect_to data_storage_providers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_storage_provider
      @data_storage_provider = DataStorageProvider.find(params[:id])
    end

    def data_storage_provider_params
      params.require(:data_storage_provider).permit(:name)
    end
end
