class HumanTargetsController < ApplicationController
  before_action :set_human_target, only: [:show, :edit, :update, :destroy]

  # GET /human_targets
  # GET /human_targets.json
  def index
    @human_targets = policy_scope(HumanTarget)
  end

  # GET /human_targets/1
  # GET /human_targets/1.json
  def show
		authorize @human_target
  end

  # GET /human_targets/new
  def new
		authorize HumanTarget
    @human_target = HumanTarget.new
  end

  # GET /human_targets/1/edit
  def edit
		authorize @human_target
  end

  # POST /human_targets
  # POST /human_targets.json
  def create
    @human_target = HumanTarget.new(human_target_params)
		authorize @human_target
		@human_target.user = current_user

    respond_to do |format|
      if @human_target.save
        format.html { redirect_to @human_target, notice: 'Human target was successfully created.' }
        format.json { render action: 'show', status: :created, location: @human_target }
      else
        format.html { render action: 'new' }
        format.json { render json: @human_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /human_targets/1
  # PATCH/PUT /human_targets/1.json
  def update
		authorize @human_target
    respond_to do |format|
      if @human_target.update(human_target_params)
        format.html { redirect_to @human_target, notice: 'Human target was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @human_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /human_targets/1
  # DELETE /human_targets/1.json
  def destroy
		authorize @human_target
    @human_target.destroy
    respond_to do |format|
      format.html { redirect_to human_targets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_human_target
      @human_target = HumanTarget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def human_target_params
      params.require(:human_target).permit(:encode_identifier, :name)
    end
end
