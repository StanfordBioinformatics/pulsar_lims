class Api::SequencingRunsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/sequencing_runs/3
  before_action :set_sequencing_run, only: [:show, :update, :destroy, :library_sequencing_result]
  skip_after_action :verify_authorized, only: [:library_sequencing_result]

  def library_sequencing_result
    render json: @sequencing_run.library_sequencing_result(params[:library_id]), root: false
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
    @sequencing_runs = policy_scope(SequencingRun).order("lower(name)")
    render json: @sequencing_runs
  end

  def show
    authorize @sequencing_run
    render json: @sequencing_run
  end

  def create
    @sequencing_run = SequencingRun.new(sequencing_run_params)
    @sequencing_run.user = @current_user
    authorize @sequencing_run
    if @sequencing_run.save
      render json: @sequencing_run, status: :created
    else
      render json: { errors: @sequencing_run.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @sequencing_run
    if @sequencing_run.update(sequencing_run_params)
      render json: @sequencing_run, status: 200
    else
      render json: { errors: @sequencing_run.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@sequencing_run)
  end

  private

  def set_sequencing_run
    @sequencing_run = SequencingRun.find(params[:id])
  end

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
        :submitted_by_id
    )
  end
end
