class ExperimentTypesController < ApplicationController
  before_action :set_experiment_type, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
		authorize @experiment_type
  end

  def new
		authorize ExperimentType
    @experiment_type = ExperimentType.new
  end

  def edit
		authorize @experiment_type
  end

  def create
    @experiment_type = ExperimentType.new(experiment_type_params)
		authorize @experiment_type
		@experiment_type.user = current_user

    respond_to do |format|
      if @experiment_type.save
        format.html { redirect_to @experiment_type, notice: 'Experiment type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @experiment_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @experiment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @experiment_type
    respond_to do |format|
      if @experiment_type.update(experiment_type_params)
        format.html { redirect_to @experiment_type, notice: 'Experiment type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @experiment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @experiment_type
		ddestroy(@experiment_type,experiment_types_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiment_type
      @experiment_type = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiment_type_params
      params.require(:experiment_type).permit(:name)
    end
end
