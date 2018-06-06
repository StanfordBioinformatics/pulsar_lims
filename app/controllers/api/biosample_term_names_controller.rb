class Api::BiosampleTermNamesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosample_term_names/3
  before_action :set_biosample_term_name, only: [:show]

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
    @biosample_term_names = policy_scope(BiosampleTermName).order("lower(name)")
    render json: @biosample_term_names
  end

  def show
    authorize @biosample_term_name
    render json: @biosample_term_name
  end

  def create
    @biosample_term_name = BiosampleTermName.new(biosample_term_name_params)
    @biosample_term_name.user = @current_user
    authorize @biosample_term_name
    if @biosample_term_name.save
      render json: @biosample_term_name, status: 201
    else
      render json: { errors: @biosample_term_name.errors.full_messages }, status: 422
    end
  end

  private

  def set_biosample_term_name
    @biosample_term_name = BiosampleTermName.find(params[:id])
  end

  def biosample_term_name_params
    params.require(:biosample_term_name).permit(
      :user_id,
      :accession,                                                                                      
      :biosample_ontology_id,                                                                          
      :name,                                                                                           
      :url                                                                                             
    )
  end
end
