class SequencingRunsController < ApplicationController
  before_action :set_sequencing_run, only: [:show, :edit, :update, :destroy, :new_sequencing_result, :add_storage_location]
	before_action :set_sequencing_request
	skip_after_action :verify_authorized, only: [:new_sequencing_result,:add_storage_location]

	def add_storage_location 
		@file_reference = @sequencing_run.build_storage_location({user_id: current_user.id})
		flash[:action] = :show
	end

	def new_sequencing_result
		@sequencing_result = @sequencing_run.sequencing_results.build	
		flash[:action] = "show"
		render layout: "fieldset_sequencing_result", partial: "add_sequencing_result"
	end

  def index
    @sequencing_runs = policy_scope(SequencingRun).order("lower(name)")
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
		@sequencing_run.user = current_user

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
    respond_to do |format|
      if @sequencing_run.update(sequencing_run_params)
        format.html { redirect_to [@sequencing_request,@sequencing_run], notice: 'Sequencing run was successfully updated.' }
        format.json { head :no_content }
      else
        action = flash[:action]
        if action.present?
					#set again for next request.
          flash[:action] = action
        end 
        format.html { render action: action }
        format.json { render json: @sequencing_run.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @sequencing_run
		ddestroy(@sequencing_run,@sequencing_request)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_run
      @sequencing_run = SequencingRun.find(params[:id])
    end

		def set_sequencing_request
			@sequencing_request = SequencingRequest.find(params[:sequencing_request_id])
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_run_params
      params.require(:sequencing_run).permit(:sequencing_run_id, :name, :sequencing_request_id, :lane, :comment, sequencing_results_attributes: [:library_id, :sequencing_run_id, :comment, :read1_uri, :read2_uri, :read1_count, :read2_count], storage_location_attributes: [:user_id, :data_storage_id, :file_path, :fileid, :data_file_type_id])
    end
end
