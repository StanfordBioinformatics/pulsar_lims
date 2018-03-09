class SequencingPlatformsController < ApplicationController
  before_action :set_sequencing_platform, only: [:show, :edit, :update, :destroy]

  def index
    @records = policy_scope(SequencingPlatform).page params[:page]
  end

  def show
		authorize @sequencing_platform
  end

  def new
		authorize SequencingPlatform
    @sequencing_platform = SequencingPlatform.new
  end

  def edit
		authorize @sequencing_platform
  end

  def create
    @sequencing_platform = SequencingPlatform.new(sequencing_platform_params)
		authorize @sequencing_platform
		@sequencing_platform.user = current_user

    respond_to do |format|
      if @sequencing_platform.save
        format.html { redirect_to @sequencing_platform, notice: 'Sequencing platform was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sequencing_platform }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequencing_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @sequencing_platform
    respond_to do |format|
      if @sequencing_platform.update(sequencing_platform_params)
        format.html { redirect_to @sequencing_platform, notice: 'Sequencing platform was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequencing_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @sequencing_platform
		ddestroy(@sequencing_platform,sequencing_platforms_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_platform
      @sequencing_platform = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_platform_params
      params.require(:sequencing_platform).permit(:upstream, :name)
    end
end
