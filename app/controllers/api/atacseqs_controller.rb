class Api::AtacseqsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/atacseqs/3
  before_action :set_atacseq, only: [:show, :update, :destroy]
  skip_after_action :verify_authorized, only: []

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
    @atacseqs = policy_scope(Atacseq).order("lower(name)")
    render json: @atacseqs
  end

  def show
    authorize @atacseq
    render json: @atacseq
  end

  def create
    @atacseq = Atacseq.new(atacseq_params)
    @atacseq.user = @current_user
    authorize @atacseq
    if @atacseq.save
      render json: @atacseq, status: :created
    else
      render json: { errors: @atacseq.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @atacseq
    if @atacseq.update(atacseq_params)
      render json: @atacseq, status: 200
    else
      render json: { errors: @atacseq.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@atacseq)
  end

  private

  def set_atacseq
    @atacseq = Atacseq.find(params[:id])
  end

  def atacseq_params
    params.require(:atacseq).permit(
      :description,
      :name,
      :notes,
      :submitter_comments,
      :document_ids => []
    )
  end
end
