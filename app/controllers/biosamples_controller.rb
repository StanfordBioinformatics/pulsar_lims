class BiosamplesController < ApplicationController
#  include DocumentsConcern #gives me add_documents(), remove_documents()
  before_action :set_biosample, only: [:show, :edit, :update, :destroy, :biosample_parts, :prototype_instances, :clone, :create_clones, :delete_biosample_document,:add_crispr_modification]
  skip_after_action :verify_authorized, only: [:biosample_parts, :prototype_instances, :select_biosample_term_name,:add_crispr_modification]

  def clone
    # Renders the view that submits a form to the create_clones action below.
    authorize @biosample, :create?
  end

  def create_clones
    authorize @biosample, :create?
    num_clones = params[:copies].to_i
    (1..num_clones).each do |num|
      biosample_clone = @biosample.clone_biosample(associated_user_id: current_user.id)
      # Add any has_one relationships to clone
      #@biosample.clone_crispr_modification(associated_biosample_id: biosample_clone.id, associated_user_id: current_user.id)
    end
    redirect_to biosamples_url, notice: "Your #{num_clones} clones have been created!"
  end

  def biosample_parts 
    #Called via ajax
    set_model_class()
    @records = policy_scope(Biosample.where({part_of: @biosample})).page params[:page]
    @no_new_btn = true
    @title = "Child biosamples of #{@biosample.name}"
    render action: "index" 
  end
    
  def prototype_instances
    #Called via ajax
    set_model_class()
    @records = policy_scope(Biosample.where({from_prototype: @biosample})).page params[:page]
    @no_new_btn = true
    @title = "Prototype instances of Biosample #{@biosample.name}"
    render action: "index" 
  end

  def select_options
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a biosamples selection.
    @records = Biosample.non_plated
    render "application_partials/select_options", layout: false
  end

  def add_crispr_modification
    @crispr = @biosample.build_crispr_modification({user: current_user})
  end

  def select_biosample_term_name
    biosample_type = BiosampleType.find(params[:biosample_type_selector])
    biosample_term_name_id = params[:biosample_term_name_selector]
    #here I pass in param biosample_term_name_selector in biosamples.js.coffee in order to save the
    # selected biosample_term_name, if there is one selected. That way, if there is a validation error
    # when the user submits the form (perhaps regarding some other field), I can set the biosample_term_name
    # to what the user had already set it to.  Normally, it would be reset to what it was since on a page re-render,
    # the AJAX request goes through again to repopulate the list of possible values for the biosample_term_name, based on teh
    # biosample_type selection.
    biosample_term_name = nil
    if biosample_term_name_id.present?
      biosample_term_name = BiosampleTermName.find(biosample_term_name_id)
    end
    @biosample_term_name_selection = BiosampleType.get_biosample_term_names(biosample_type.id)
    @selected = nil
    if biosample_term_name.present?
      @selected = biosample_term_name.id
    end
    render layout: false
  end

  def index
    super(where: {well: nil})
  end

  def show
    authorize @biosample
  end

  def new
    authorize Biosample
    @biosample = Biosample.new
  end

  def edit
    authorize @biosample
  end

  def create
    authorize Biosample
    @biosample = Biosample.new(biosample_params)
    @biosample.user = current_user
    #@biosample = add_documents(@biosample,params[:biosample][:document_ids])

    #render json: biosample_params
    #return
    respond_to do |format|
      if @biosample.save
        format.html { redirect_to @biosample, notice: 'Biosample was successfully created.' }
        format.json { render action: 'show', status: :created, location: @biosample }
      else
        format.html { render action: 'new' }
        format.json { render json: @biosample.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @biosample
    #@biosample = add_documents(@biosample,params[:biosample][:documents])
    #render json: params
    #return
    crispr_attrs = biosample_params()[:crispr_modification_attributes]
    if crispr_attrs.present?
      params[:biosample][:crispr_modification_attributes].update({user_id: current_user.id})
    end
    respond_to do |format|
      if @biosample.update(biosample_params)
        format.html { redirect_to @biosample, notice: 'Biosample was successfully updated.' }
        format.json { head :no_content }
      else
        action = flash[:action]
        if action.present?
          #set again for next request.
          flash[:action] = action
        end
        format.html { render flash[:action] || 'edit' }
        format.json { render json: @biosample.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @biosample
    ddestroy(@biosample,biosamples_path)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biosample
      @biosample = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biosample_params
      params.require(:biosample).permit(
        :biosample_term_name_id, 
        :biosample_type_id,
        :control, 
        :date_biosample_taken, 
        :description, 
        :donor_id,
        :lot_identifier, 
        :name, 
        :notes,
        :nih_institutional_certification,
        :owner_id, 
        :part_of_id, 
        :passage_number, 
        :starting_amount,
        :starting_amount_units,
        :submitter_comments, 
        :tissue_preservation_method, 
        :tube_label,
        :upstream_identifier, 
        :vendor_id,
        :vendor_product_identifier, 
        
        documents_attributes: [:id, :_destroy], 
        :document_ids => [], 
        pooled_from_biosamples_attributes: [:id, :_destroy], 
        :pooled_from_biosample_ids => [], 
        treatments_attributes: [:id, :_destroy], 
        :treatment_ids => []
    )
    end
end
