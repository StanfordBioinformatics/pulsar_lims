class ChipseqExperimentsController < ApplicationController
  before_action :set_chipseq_experiment, only: [:show, :edit, :update, :destroy]

  # GET /chipseq_experiments
  # GET /chipseq_experiments.json
  def index
    @chipseq_experiments = ChipseqExperiment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chipseq_experiments }
    end
  end

  # GET /chipseq_experiments/1
  # GET /chipseq_experiments/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chipseq_experiment }
    end
  end

  # GET /chipseq_experiments/new
  def new
    @chipseq_experiment = ChipseqExperiment.new
  end

  # GET /chipseq_experiments/1/edit
  def edit
  end

  # POST /chipseq_experiments
  # POST /chipseq_experiments.json
  def create
    @chipseq_experiment = ChipseqExperiment.new(chipseq_experiment_params)

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

  # PATCH/PUT /chipseq_experiments/1
  # PATCH/PUT /chipseq_experiments/1.json
  def update
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

  # DELETE /chipseq_experiments/1
  # DELETE /chipseq_experiments/1.json
  def destroy
    @chipseq_experiment.destroy
    respond_to do |format|
      format.html { redirect_to chipseq_experiments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chipseq_experiment
      @chipseq_experiment = ChipseqExperiment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chipseq_experiment_params
      params.require(:chipseq_experiment).permit(:user_id, :name, :description, :upstream_identifier, :target_id, :submitter_comments, :notes)
    end
end
