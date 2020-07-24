class Api::PrimersController < Api::ApplicationController
  before_action :set_primer, only: [:show, :update, :destroy]

  def select_options                                                                                   
    #Called via ajax.                                                                                  
    #Typically called when the user selects the refresh icon in any form that has a primer selection.
    if params[:direction] == Primer::FORWARD_D
      @records = Primer.forward
    else
      @records = Primer.reverse
    end
    render "application_partials/select_options", layout: false                                        
  end  

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
    @primers = policy_scope(Primer).order("lower(name)")
    render json: @primers
  end

  def show
    authorize @primer
    render json: @primer
  end

  def create
    @primer = Primer.new(primer_params)
    @primer.user = @current_user 
    authorize @primer

    if @primer.save
      render json: @primer, status: :created 
    else
      render json: { errors: @primer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @primer
    if @primer.update(primer_params)
      render json: @primer, status: 200 
    else
      render json: { errors: @primer.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@primer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_primer
      @primer = Primer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def primer_params
      params.require(:primer).permit(
        :date_ordered,
        :description,
        :designed_by_id,
        :direction,
        :melting_temperature,
        :name, 
        :notes,
        :ordered_from_id,
        :sequence,
        :target_id)
    end
end
