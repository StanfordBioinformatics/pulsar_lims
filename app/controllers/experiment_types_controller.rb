class ExperimentTypesController < ApplicationController
  before_action :set_experiment_type, only: [:show, :edit, :update, :destroy]

  # GET /experiment_types
  # GET /experiment_types.json
  def index
    @experiment_types = ExperimentType.all
  end

  # GET /experiment_types/1
  # GET /experiment_types/1.json
  def show
  end

  # GET /experiment_types/new
  def new
    @experiment_type = ExperimentType.new
  end

  # GET /experiment_types/1/edit
  def edit
  end

  # POST /experiment_types
  # POST /experiment_types.json
  def create
    @experiment_type = ExperimentType.new(experiment_type_params)

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

  # PATCH/PUT /experiment_types/1
  # PATCH/PUT /experiment_types/1.json
  def update
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

  # DELETE /experiment_types/1
  # DELETE /experiment_types/1.json
  def destroy
    @experiment_type.destroy
    respond_to do |format|
      format.html { redirect_to experiment_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiment_type
      @experiment_type = ExperimentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiment_type_params
      params.require(:experiment_type).permit(:name)
    end
end
