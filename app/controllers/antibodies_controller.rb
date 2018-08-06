class AntibodiesController < ApplicationController
  include AntibodyPurificationsConcern #provides add_antibody_purifications()
  before_action :set_antibody, only: [:show, :edit, :update, :destroy]

  def select_options                                                                                   
    #Called via ajax.                                                                                  
    #Typically called when the user selects the refresh icon in any form that has an input for the users model.
    @records = Antibody.all                                                                              
    render "application_partials/select_options", layout: false                                        
  end  

  def index
    super
  end

  def show
    authorize @antibody
  end

  def new
    authorize Antibody
    @antibody = Antibody.new
  end

  def edit
    authorize @antibody
  end

  def create
    @antibody = Antibody.new(antibody_params)
    authorize @antibody
    @antibody.user = current_user
    @antibody = add_antibody_purifications(@antibody,params[:antibody][:antibody_purification_ids])
    #@antibody.add_antibody_purifications(params[:antibody][:antibody_purifications])
    
    respond_to do |format|
      if @antibody.save
        format.html { redirect_to @antibody, notice: 'Antibody was successfully created.' }
        format.json { render action: 'show', status: :created, location: @antibody }
      else
        format.html { render action: 'new' }
        format.json { render json: @antibody.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @antibody
    @antibody = add_antibody_purifications(@antibody,params[:antibody][:antibody_purification_ids])
    #@antibody.remove_antibody_purifications(params[:remove_antibody_purifications])
    #@antibody.add_antibody_purifications(params[:antibody][:antibody_purifications])
    respond_to do |format|
      if @antibody.update(antibody_params)
        format.html { redirect_to @antibody, notice: 'Antibody was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @antibody.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@antibody, redirect_path_success: antibodies_path)
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
