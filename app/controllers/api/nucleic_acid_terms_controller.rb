class Api::NucleicAcidTermsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/nucleic_acid_terms/3
  before_action :set_nucleic_acid_term, only: [:show, :update, :destroy]

  def find_by
    #find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

  def show
    authorize @nucleic_acid_term
    render json: @nucleic_acid_term
  end

  def create
    @nucleic_acid_term = NucleicAcidTerm.new(nucleic_acid_term_params)
    @nucleic_acid_term.user = @current_user
    authorize @nucleic_acid_term, :create?
    if @nucleic_acid_term.save
      render json: @nucleic_acid_term, status: 201
    else
      render json: { errors: @nucleic_acid_term.errors.full_messages }, status: 422
    end
  end

  def update
    authorize @nucleic_acid_term
    if @nucleic_acid_term.update(nucleic_acid_term_params)
      render json: @nucleic_acid_term, status: 200
    else
      render json: { errors: @nucleic_acid_term.errors.full_messages }, status: 422
    end
  end

  def destrooy
    ddestroy(@nucleic_acid_term)
  end

  private

  def set_nucleic_acid_term
    @nucleic_acid_term = NucleicAcidTerm.find(params[:id])
  end

  def nucleic_acid_term_params
    params.require(:nucleic_acid_term).permit(
      :accession,
      :definition,
      :name
    )
  end
end
