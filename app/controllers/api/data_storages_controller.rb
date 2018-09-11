class Api::DataStoragesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/data_storages/3
  before_action :set_data_storage, only: [:show, :update, :destroy]

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
    @data_storages = policy_scope(DataStorage).order("lower(name)")
    render json: @data_storages
  end

  def show
    authorize @data_storage
    render json: @data_storage
  end

  def create
    @data_storage = DataStorage.new(data_storage_params)
    @data_storage.user = @current_user
    authorize @data_storage
    if @data_storage.save
      render json: @data_storage, status: :created
    else
      render json: { errors: @data_storage.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @data_storage
    if @data_storage.update(data_storage_params)
      render json: @data_storage, status: 200
    else
      render json: { errors: @data_storage.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@data_storage)
  end

  private

  def set_data_storage
    @data_storage = DataStorage.find(params[:id])
  end

  def data_storage_params
    params.require(:data_storage).permit(
        :bucket,                                                                                       
        :data_storage_provider_id,                                                                     
        :folder_base_path,                                                                             
        :name,                                                                                         
        :notes,                                                                                        
        :project_identifier 
    )
  end
end
