class Api::BiosampleOntologiesController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosample_ontologies/3
  before_action :set_biosample_ontology, only: [:show]

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
    @biosample_ontologies = policy_scope(BiosampleOntology).order("lower(name)")
    render json: @biosample_ontologies
  end

  def show
    authorize @biosample_ontology
    render json: @biosample_ontology
  end

  def create
    @biosample_ontology = BiosampleOntology.new(biosample_ontology_params)
    @biosample_ontology.user = @current_user
    authorize @biosample_ontology
    if @biosample_ontology.save
      render json: @biosample_ontology, status: 201
    else
      render json: { errors: @biosample_ontology.errors.full_messages }, status: 422
    end
  end

  private

  def set_biosample_ontology
    @biosample_ontology = BiosampleOntology.find(params[:id])
  end

  def biosample_ontology_params
    params.require(:biosample_ontology).permit(
      :user_id,
      :name,
      :notes,
      :url
    )
  end
end
