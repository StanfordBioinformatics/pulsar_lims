class SingleCellSortingsController < ApplicationController
  before_action :set_single_cell_sorting, only: [:show, :edit, :update, :destroy, :add_sorting_biosample, :add_plate, :add_library_prototype, :new_analysis]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  skip_after_action :verify_authorized, only: [:add_sorting_biosample, :add_plate, :add_library_prototype, :new_analysis]

  def new_analysis
    #non AJAX
    @analysis = @single_cell_sorting.analyses.build
    flash[:action] = :new_analysis
  end 

  def add_library_prototype
    #non AJAX
    custom_lib_params = {
      prototype: true,
      name: "#{@single_cell_sorting.name} library prototype"
    }
    @library = @single_cell_sorting.build_library_prototype(custom_lib_params)
    flash[:action] = :add_library_prototype
  end

  def add_plate
    #called via AJAX
    @plate = @single_cell_sorting.plates.build
    #Needed to set @plate above since that is used in the partial single_cell_sortings/_add_plate.html.erb that renders a Plate form. -->
    render partial: "add_plate", layout: false
    flash[:action] = "show"
  end

  def add_sorting_biosample
    #called via AJAX
    sorting_biosample_attrs = @single_cell_sorting.starting_biosample.attributes_for_cloning()
    sorting_biosample_attrs.update({
      name: @single_cell_sorting.name + " " + "biosample prototype",
      user_id: current_user.id
    })
    sorting_biosample = Biosample.new(sorting_biosample_attrs)
    @biosample = sorting_biosample
    #Needed to set @biosample above since that is used in the partial single_cell_sortings/_add_sorting_biosample.html.erb that renders a Biosample form. -->
    render partial: "add_sorting_biosample", layout: false
    flash[:action] = "show"
  end 

  def index
    @records = policy_scope(SingleCellSorting).page params[:page]
  end

  def show
    authorize @single_cell_sorting
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @single_cell_sorting }
    end
  end

  def new
    authorize SingleCellSorting
    @single_cell_sorting = SingleCellSorting.new
  end

  def edit
    authorize @single_cell_sorting
  end

  def create
    authorize SingleCellSorting
    @single_cell_sorting = SingleCellSorting.new(single_cell_sorting_params)
    @single_cell_sorting.user = current_user

    respond_to do |format|
      if @single_cell_sorting.save
        format.html { redirect_to @single_cell_sorting, notice: 'Single cell sorting was successfully created.' }
        format.json { render json: @single_cell_sorting, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @single_cell_sorting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @single_cell_sorting
    #render json: params
    #return
    scs_params = single_cell_sorting_params

    if scs_params[:library_prototype_attributes].present? and scs_params[:library_prototype_attributes][:id].blank?
      #Then user is adding the library_prototype.
      scs_params[:library_prototype_attributes][:user_id] = current_user.id
    end

    if scs_params[:sorting_biosample_attributes].present? and scs_params[:sorting_biosample_attributes][:id].blank?
      #Then user is adding the sorting biosample. 
      scs_params[:sorting_biosample_attributes][:user_id] = current_user.id
    end
    if scs_params[:plates_attributes].present?
      scs_params[:plates_attributes].each do |pos,plate_params| #keys are integers, like indices in a list.
        next if plate_params.include?(:id) #Because the user is updating a plate
        scs_params[:plates_attributes][pos][:user_id] = current_user.id
      end
    end
    respond_to do |format|
      begin
        res = @single_cell_sorting.update(scs_params)
      rescue RuntimeError => e
        res = false
        flash[:alert] = e.message
      end
      if res
        format.html { redirect_to @single_cell_sorting, notice: 'Single cell sorting was successfully updated.' }
        format.json { head :no_content }
      else
        action = flash[:action]
        if action.present?
          #set again for next request.
          flash[:action] = action
        end
        format.html { render flash[:action] || 'edit' } 
        #format.html { render json: @single_cell_sorting.errors }
        #format.html { render json: @single_cell_sorting.errors }
        format.json { render json: @single_cell_sorting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@single_cell_sorting, single_cell_sortings_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_single_cell_sorting
      @single_cell_sorting = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def single_cell_sorting_params
      params.require(:single_cell_sorting).permit(
        :description, 
        :fluorescence_intensity_file, 
        :library_prototype_id, 
        :name, 
        :notes,
        :sorting_biosample_id, 
        :starting_biosample_id, 
        :upstream, 
        :document_ids => [], 
        documents_attributes: [:id,:_destroy], 
        library_prototype_attributes: [
          :biosample_id,
          :concentration, 
          :concentration_unit_id, 
          :is_control, 
          :library_fragmentation_method_id, 
          :lot_identifier, 
          :name, 
          :nucleic_acid_term_id, 
          :paired_end,
          :prototype,
          :sequencing_library_prep_kit_id, 
          :size_range, 
          :strand_specific, 
          :vendor_id, 
          :vendor_product_identifier, 
          :document_ids => []
        ],
        sorting_biosample_attributes: [
          :biosample_term_name_id, 
          :biosample_type_id,
          :control, 
          :date_biosample_taken, 
          :description, 
          :donor_id,
          :lot_identifier, 
          :name, 
          :part_of_id, 
          :passage_number, 
          :submitter_comments, 
          :upstream, 
          :vendor_id,
          :vendor_product_identifier, 
          :document_ids => [], 
          documents_attributes: [:id,:_destroy]
        ], 
        plates_attributes: [
          :dimensions, 
          :name, 
          :starting_biosample_id, 
          :vendor_id, 
          :vendor_product_identifier,
          antibody_ids: []
        ],
        analyses_ids: []
      )
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "fluorescence_intensity/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
      #From the AWS docs, regarding the 201 here: If the value is set to 201, Amazon S3 returns an XML document with a 201 status code.
      #If we don't set the acl, then the file is not readable by others.
      #Also using #{SecureRandom.uuid} so that users don't overwrite an existing file with the same name. 
    end 
end
