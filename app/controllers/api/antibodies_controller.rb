class Api::AntibodiesController < Api::ApplicationController
  
  before_action :set_antibody, only: [:show, :update, :destroy]

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

  def index
    super
  end
  
  def show
    authorize @antibody
    render json: @antibody
  end

  def new
    authorize Antibody
    @antibody = Antibody.new
  end

  def create
    @antibody = Antibody.new(antibody_params)
    @antibody.user = current_user
    authorize @antibody
    @antibody = add_antibody_purifications(@antibody,params[:antibody][:antibody_purification_ids])
    #@antibody.add_antibody_purifications(params[:antibody][:antibody_purifications])
    
    if @antibody.save
      render json: @antibody, status: :created
    else
      render json: { errors: @antibody.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @antibody
    @antibody = add_antibody_purifications(@antibody,params[:antibody][:antibody_purification_ids])
    #@antibody.remove_antibody_purifications(params[:remove_antibody_purifications])
    #@antibody.add_antibody_purifications(params[:antibody][:antibody_purifications])
    if @antibody.update(antibody_params)
      render json: @antibody, status: 200 
    else
      render json: { errors: @antibody.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@antibody)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_antibody
      @antibody = set_record(controller_name,params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def antibody_params
      params.require(:antibody).permit(
        :antigen_description,
        :antigen_sequence,
        :clonality,
        :concentration, 
        :concentration_units_id,
        :isotype_id,
        :lot_identifier,
        :name,
        :notes,
        :organism_id,
        :target_id,
        :upstream_identifier,
        :vendor_id,
        :vendor_product_identifier,
        :vendor_product_url,
        antibody_purifications_attributes: [
          :id,
          :_destroy
        ]
      )
    end

end
