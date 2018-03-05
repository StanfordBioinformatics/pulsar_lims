class TargetsController < ApplicationController
  before_action :set_target, only: [:show, :edit, :update, :destroy]

  def index
    @records = policy_scope(Target).order("lower(name)").page params[:page]
  end

  def show
		authorize @target
  end

  def new
		authorize Target
    @target = Target.new
  end

  def edit
		authorize @target
  end

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

  def destroy
		authorize @target
		ddestroy(@target,targets_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_params
      params.require(:target).permit(:refseq, :ensembl, :upstream, :name)
    end
end
