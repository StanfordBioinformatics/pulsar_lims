class TargetsController < ApplicationController
  before_action :set_target, only: [:show, :edit, :update, :destroy]

  # GET /targets
  # GET /targets.json
  def index
    @targets = policy_scope(Target).order("lower(name)")
  end

  # GET /targets/1
  # GET /targets/1.json
  def show
		authorize @target
  end

  # GET /targets/new
  def new
		authorize Target
    @target = Target.new
  end

  # GET /targets/1/edit
  def edit
		authorize @target
  end

  # POST /targets
  # POST /targets.json
  def create
    @target = Target.new(target_params)
		authorize @target
		@target.user = current_user

    respond_to do |format|
      if @target.save
        format.html { redirect_to @target, notice: 'Target was successfully created.' }
        format.json { render action: 'show', status: :created, location: @target }
      else
        format.html { render action: 'new' }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /targets/1
  # PATCH/PUT /targets/1.json
  def update
		authorize @target
    respond_to do |format|
      if @target.update(target_params)
        format.html { redirect_to @target, notice: 'Target was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.json
  def destroy
		authorize @target
    @target.destroy
    respond_to do |format|
      format.html { redirect_to targets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = Target.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_params
      params.require(:target).permit(:encode_identifier, :name)
    end
end
