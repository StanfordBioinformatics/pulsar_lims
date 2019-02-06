class ChipseqExperimentsController < ApplicationController
  before_action :set_chipseq_experiment, only: [:show, :edit, :update, :destroy, :select_experimental_biosample, :select_control_biosample, :create_control_replicate]
  skip_after_action :verify_authorized, only: [:select_experimental_biosample, :select_control_biosample, :create_control_replicate, :get_wt_control_selection, :select_biosample_libraries]

  def select_biosample_libraries
    # AJAX call from ChipseqExperiment show view when user clicks on the "Add experiment replicate"
    # button or the "Add control replicate" button and then selects a biosample.
    # The call is made from chipseq_experiments.js.coffee.
    @biosample = Biosample.find(params[:biosample_id])
    @chipseq_experiment = ChipseqExperiment.new # For simple_fields_for in the view
    @libraries = @biosample.libraries
    render layout: false
  end

  def get_wt_control_selection
    starting_biosample = Biosample.find(params["starting_biosample_id"])
    @wild_type_controls = Biosample.wild_type_controls.where(biosample_term_name_id: starting_biosample.biosample_term_name_id)
    @chipseq_experiment = ChipseqExperiment.new
    render layout: false
  end

  def select_experimental_biosample
    # AJAX from show view when user clicks on the "Add experiment replicate" button.
    starting_biosamples = @chipseq_experiment.chipseq_starting_biosamples
    selection = []
    starting_biosamples.each do |s|
      # Don't include biosamples that are already in self.replicates in the selection.
      selection.concat(s.biosample_parts.where.not(id: @chipseq_experiment.replicates))
    end
    @selection = selection
    render partial: "select_experimental_or_ctl_biosample", locals: {heading: "Add experimental replicates"}
  end

  def select_control_biosample
    # AJAX from show view when user clicks on the "Add control replicate" button.
    starting_biosamples = @chipseq_experiment.chipseq_starting_biosamples
    controls = Set.new()
    starting_biosamples.each do |s|
      controls.merge(s.control_descendents())
    end
    @selection = controls.to_a
    render partial: "select_experimental_or_ctl_biosample", locals: {heading: "Add control replicates"}
  end


#  def select_controls
#    # Called remotely. Renders a form that POSTS to create_control_replicate action below.
#    @selection = @chipseq_experiment.replicates
#    render layout: false
#  end
#
#  def create_control_replicate
#    # Called via POST from select_controls action's template.
#    replicate_ids = chipseq_experiment_params[:replicate_ids].select{|x| x.present?}
#    first_rep = Biosample.find(replicate_ids[0])
#    input_cnt = @chipseq_experiment.control_replicates.length + 1
#    name = "#{@chipseq_experiment.target.name} #{first_rep.biosample_term_name.name} input #{input_cnt}"
#    custom_attrs = {
#      part_of_id: nil,
#      from_prototype_id: nil,
#      pooled_from_biosample_ids: replicate_ids,
#      name: name,
#      control: true,
#      chipseq_experiment_id: @chipseq_experiment.id
#    }
#    clone = first_rep.clone_biosample(associated_user_id: current_user.id, custom_attrs: custom_attrs)
#    flash[:notice] = "Control biosample #{clone.to_label()} was successfully created."
#    redirect_to @chipseq_experiment
#  end

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
        :wild_type_control_id,
        :chipseq_starting_biosample_ids => [],
        :document_ids => [],
        :replicate_ids => [],
        :control_replicate_ids => [],
        documents_attributes: [:id, :_destroy]
      )
    end
end
