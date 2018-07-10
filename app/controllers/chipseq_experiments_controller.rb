class ChipseqExperimentsController < ApplicationController
  before_action :set_chipseq_experiment, only: [:show, :edit, :update, :destroy, :add_biosample_replicate]
  skip_after_action :verify_authorized, only: [:add_biosample_replicate]

  def add_biosample_replicate
    # Required Params: 
    #     control: bool. true means that this is a control biosample_replicate. 
    @control = params[:control]
    @biosample_replicate = @chipseq_experiment.experiment_biosample_replicates.build({control: @control})
    flash[:redirect] = chipseq_experiment_url(@chipseq_experiment)
    render "biosample_replicates/new"
  end

  def index
    super
  end

  def show
    authorize @chipseq_experiment
  end

  def new
    authorize ChipseqExperiment.new
    @chipseq_experiment = ChipseqExperiment.new
  end

  def edit
    authorize @chipseq_experiment
  end

  def create
    authorize ChipseqExperiment
    #render json: params
    #return
    @chipseq_experiment = ChipseqExperiment.new(chipseq_experiment_params)
    @chipseq_experiment.user = current_user

    respond_to do |format|
      if @chipseq_experiment.save
        format.html { redirect_to @chipseq_experiment, notice: 'Chipseq experiment was successfully created.' }
        format.json { render json: @chipseq_experiment, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @chipseq_experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @chipseq_experiment
    #render json: params
    #return
    respond_to do |format|
      if @chipseq_experiment.update(chipseq_experiment_params)
        format.html { redirect_to @chipseq_experiment, notice: 'Chipseq experiment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chipseq_experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@chipseq_experiment, redirect_path_success: chipseq_experiments_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chipseq_experiment
      @chipseq_experiment = ChipseqExperiment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chipseq_experiment_params
      params.require(:chipseq_experiment).permit(
        :name, 
        :description, 
        :notes,
        :submitter_comments, 
        :target_id, 
        :upstream_identifier, 
        :wild_type_input_id, 
        :document_ids => [],
        :control_biosample_replicate_ids => [],
        :experiment_biosample_replicate_ids => [],
        documents_attributes: [:id, :_destroy]
      )
    end
end
