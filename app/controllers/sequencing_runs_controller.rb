class SequencingRunsController < ApplicationController
  before_action :set_sequencing_run, only: [:show, :edit, :update, :destroy, :new_sequencing_result]
  before_action :set_sequencing_request
  skip_after_action :verify_authorized, only: [:new_sequencing_result, :add_data_storage]

  def add_data_storage
    # AJAX from show view.
    @sequencing_run = @sequencing_request.sequencing_runs.build
    if params[:select]
      @select = true
    elsif params[:build]
      @build = true
      @sequencing_run.build_data_storage({user_id: current_user.id})
    end
    render layout: false
  end

  def new_sequencing_result
    @sequencing_result = @sequencing_run.sequencing_results.build({merged: false})
    flash[:action] = "show"
    render layout: "fieldset_sequencing_result", partial: "add_sequencing_result"
  end

  def all
    #This action stands in for a non-scoped index view. See the "index" action below for the 
    # scoped index view.
  end

  def index
    #This index method is only for scoped index views through the sequencing_request object.
    #See the "all" action above for the non-scoped form of the index view.
    @records = @sequencing_request.sequencing_runs.page params[:page]
    policy_scope(SequencingRun)
  end

  def show
    authorize @sequencing_run
  end

  def new
    @sequencing_run = @sequencing_request.sequencing_runs.build
    authorize @sequencing_run
  end

  def edit
    authorize @sequencing_run
  end

  def create
    @sequencing_run = @sequencing_request.sequencing_runs.build(sequencing_run_params)
    authorize @sequencing_run
    #render json: params
    #return
    @sequencing_run.user = current_user
    if @sequencing_run.data_storage.present? and @sequencing_run.data_storage.user.blank?
      @sequencing_run.data_storage.user = current_user
    end

    respond_to do |format|
      if @sequencing_run.save
        format.html { redirect_to [@sequencing_request,@sequencing_run], notice: 'Sequencing run was successfully created.' }
        format.json { render json: @sequencing_run, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequencing_run.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @sequencing_run
    params = sequencing_run_params
    #Check for the addition of new sequencing_result objects. If present, we'll need to fill in
    # the value for the 'user' attribute. If there is a new one, params would look like:
    # {"sequencing_results_attributes"=>{"0"=>{"library_id"=>"136", "sequencing_run_id"=>"10", "comment"=>"", "read1_uri"=>"", "read1_count"=>""}}
    if params[:sequencing_results_attributes].present?
      results = params[:sequencing_results_attributes]
      results.each do |num,|
        if results[num]["id"].nil?
          results[num]["user_id"] = current_user.id
        end
      end
    end

    respond_to do |format|
      if @sequencing_run.update(params)
        format.html { redirect_to [@sequencing_request, @sequencing_run], notice: 'Sequencing run was successfully updated.' }
        format.json { head :no_content }
      else
        action = flash[:action]
        if action.present?
          #set again for next request.
          flash[:action] = action
        end 
        format.html { render action || "edit" }
        format.json { render json: @sequencing_run.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@sequencing_run, redirect_path_success: @sequencing_request)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_run
      @sequencing_run = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    def set_sequencing_request
      @sequencing_request = set_record("SequencingRequest",params[:sequencing_request_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_run_params
      params.require(:sequencing_run).permit(
        :comment,
        :data_storage_id,
        :date_submitted,
        :forward_read_len,
        :lane,
        :name,
        :notes,
        :report_id,
        :reverse_read_len,
        :sequencing_request_id,
        :status,
        :submitted_by_id,
        sequencing_results_attributes: [
          :library_id,
          :merged,
          :sequencing_run_id,
          :read1_uri,
          :read2_uri,
          :read1_count,
          :read2_count
        ],
        data_storage_attributes: [
          :bucket,                                                                                       
          :data_storage_provider_id,                                                                     
          :folder_base_path,                                                                             
          :name,                                                                                         
          :notes,                                                                                        
          :project_identifier 
        ]
      )
    end
end
