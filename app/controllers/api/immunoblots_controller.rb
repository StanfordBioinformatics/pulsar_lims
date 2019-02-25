class Api::ImmunoblotsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/immunoblots/3
  before_action :set_immunoblot, only: [:show, :update, :destroy]

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
    @immunoblots = policy_scope(Immunoblot).order("lower(name)")
    render json: @immunoblots
  end

  def show
    authorize @immunoblot
    render json: @immunoblot
  end

  def create
    @immunoblot = Immunoblot.new(immunoblot_params)
    @immunoblot.user = @current_user
    authorize @immunoblot
    if @immunoblot.save
      render json: @immunoblot, status: :created
    else
      render json: { errors: @immunoblot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @immunoblot
    if @immunoblot.update(immunoblot_params)
      render json: @immunoblot, status: 200
    else
      render json: { errors: @immunoblot.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@immunoblot)
  end

  private

  def set_immunoblot
    @immunoblot = Immunoblot.find(params[:id])
  end

  def immunoblot_params
    params.require(:immunoblot).permit(
      :analyst_id,                                                                                   
      :date_performed,                                                                               
      :name,                                                                                         
      :notes,                                                                                        
      :pcr_id,                                                                                       
      :primary_antibody_id,                                                                          
      :primary_antibody_dilution,                                                                    
      :secondary_antibody_dilution,                                                                  
      :submitter_comments,                                                                           
      document_ids: [],                                                                              
      gel_ids: [],                                                                                   
      secondary_antibody_ids: [],  
    )
  end
end
