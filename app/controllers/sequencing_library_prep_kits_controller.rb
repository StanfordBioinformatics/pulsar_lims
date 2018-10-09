class SequencingLibraryPrepKitsController < ApplicationController
  before_action :set_sequencing_library_prep_kit, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:dual_indexing_kits]

  def select_options
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a sequencing_library_prep_kits selection.
    @records = SequencingLibraryPrepKit.all                                                                        
    render "application_partials/select_options", layout: false
  end 

  def dual_indexing_kits 
    @pe_kits = SequencingLibraryPrepKit.dual_indexing_kits() #returns the entire objects in a list
    ids = @pe_kits.map do |x|
      x[:id]
    end
    render json: ids
  end

  def index
    super
  end

  def show
    authorize @sequencing_library_prep_kit
  end

  def new
    authorize SequencingLibraryPrepKit
    @sequencing_library_prep_kit = SequencingLibraryPrepKit.new
  end

  def edit
    authorize @sequencing_library_prep_kit
  end

  def create
    authorize SequencingLibraryPrepKit
    @sequencing_library_prep_kit = SequencingLibraryPrepKit.new(sequencing_library_prep_kit_params)
    @sequencing_library_prep_kit.user = current_user

    respond_to do |format|
      if @sequencing_library_prep_kit.save
        format.html { redirect_to @sequencing_library_prep_kit, notice: 'Sequencing library prep kit was successfully created.' }
        format.json { render json: @sequencing_library_prep_kit, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequencing_library_prep_kit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @sequencing_library_prep_kit

    respond_to do |format|
      if @sequencing_library_prep_kit.update(sequencing_library_prep_kit_params)
        format.html { redirect_to @sequencing_library_prep_kit, notice: 'Sequencing library prep kit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequencing_library_prep_kit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@sequencing_library_prep_kit, redirect_path_success: sequencing_library_prep_kits_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_library_prep_kit
      @sequencing_library_prep_kit = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_library_prep_kit_params
      params.require(:sequencing_library_prep_kit).permit(
        :description,
        :name,
        :notes,
        :supports_dual_indexing,
        :vendor_id,
        :vendor_product_identifier,
        documents_attributes: [:id, :_destroy]
      )
    end
end
