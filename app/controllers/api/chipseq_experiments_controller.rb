class Api::ChipseqExperimentsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/chipseq_experiments/3
  before_action :set_chipseq_experiment, only: [:show, :update, :destroy]

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
    @chipseq_experiments = policy_scope(ChipseqExperiment).order("lower(name)")
    render json: @chipseq_experiments
  end

  def show
    authorize @chipseq_experiment
    render json: @chipseq_experiment
  end

  def create
    @chipseq_experiment = ChipseqExperiment.new(chipseq_experiment_params)
    @chipseq_experiment.user = @current_user
    authorize @chipseq_experiment
    if @chipseq_experiment.save
      render json: @chipseq_experiment, status: :created
    else
      render json: { errors: @chipseq_experiment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @chipseq_experiment
    if @chipseq_experiment.update(chipseq_experiment_params)
      render json: @chipseq_experiment, status: 200
    else
      render json: { errors: @chipseq_experiment.errors.full_messages }, status: 422
    end
  end

  def destroy
    ddestroy(@chipseq_experiment)
  end

  private

  def set_chipseq_experiment
    @chipseq_experiment = ChipseqExperiment.find(params[:id])
  end

  def chipseq_experiment_params
    params.require(:chipseq_experiment).permit(
        :description,
        :name,
        :notes,
        :submitter_comments,
        :target_id,
        :starting_biosample_id,
        :upstream_identifier,
        :wild_type_control_id,
        :document_ids => [], 
        :replicate_ids => [],
        :control_replicate_ids => []
    )
  end
end
