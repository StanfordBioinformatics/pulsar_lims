class Api::CrisprModificationsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/crisprs/3
  before_action :set_crispr_modification, only: [:show]

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
    @crisprs = policy_scope(CrisprModification).order("lower(name)")
    render json: @crisprs
  end

  def show
    authorize @crispr
    render json: @crispr
  end

  def create
    @crispr = CrisprModification.new(crispr_params)
    @crispr.user = @current_user
    authorize @crispr
    if @crispr.save
      render json: @crispr, status: :created
    else
      render json: { errors: @crispr.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_crispr_modification
    @crispr = CrisprModification.find(params[:id])
  end

  def crispr_modification_params
    params.require(:crispr_modification).permit(
        :biosample_id,
        :category,
        :donor_construct_id,
        :name,
        :notes,
        :purpose,
        :_times_cloned,
        :upstream_identifier,
        crispr_construct_ids: [],
        crispr_constructs_attributes: [:id, :_destroy],
        genomic_integration_site_attributes: [:id, :chromosome_id, :start, :end]
    )
  end
end
