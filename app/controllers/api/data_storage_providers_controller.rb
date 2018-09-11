class Api::DataStorageProvidersController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/data_storage_providers/3
  before_action :set_data_storage_provider, only: [:show, :destroy, :update, :download]

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

  def download
    authorize @data_storage_provider, :show?
    # Base64 encode binary stream. Client will need to base64 decode it.
    render json: {"data": Base64.encode64(@data_storage_provider.data)}
  end

  def index
    @data_storage_providers = policy_scope(DataStorageProvider).order("lower(name)")
    render json: @data_storage_providers
  end

  def show
    authorize @data_storage_provider
    render json: @data_storage_provider
  end

  def create
    @data_storage_provider = DataStorageProvider.new(data_storage_provider_params)
    @data_storage_provider.user = @current_user
    authorize @data_storage_provider
    if @data_storage_provider.save
      render json: @data_storage_provider, status: 201
    else
      render json: { errors: @data_storage_provider.errors.full_messages }, status: 422
    end
  end

  def update
    authorize @data_storage_provider
    if @data_storage_provider.update(data_storage_provider_params)
      render json: @data_storage_provider, status: 200
    else
      render json: { errors: @data_storage_provider.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@data_storage_provider)
  end

  private

  def set_data_storage_provider
    @data_storage_provider = DataStorageProvider.find(params[:id])
  end

  def data_storage_provider_params
    params.require(:data_storage_provider).permit(
        :bucket_storage,                                                                               
        :name,                                                                                         
        :notes 
    )
  end
end
