class Api::DonorsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/donors/3
  before_action :set_donor, only: [:show, :update, :destroy]

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
    @donors = policy_scope(Donor).order("lower(name)")
    render json: @donors
  end

  def show
    authorize @donor
    render json: @donor
  end

  def create
    @donor = Donor.new(donor_params)
    @donor.user = @current_user
    authorize @donor
    if @donor.save
      render json: @donor, status: 201
    else
      render json: { errors: @donor.errors.full_messages }, status: 422
    end
  end

  def update
    authorize @donor
    if @donor.update(donor_params)
      render json: @donor, status: 200
    else
      render json: { errors: @donor.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@donor)
  end

  private

  def set_donor
    @donor = Donor.find(params[:id])
  end

  def donor_params
      params.require(:donor).permit(
        :user_id,
        :age,
        :gender,
        :name,
        :notes,
        :upstream_identifier
      )
  end
end
