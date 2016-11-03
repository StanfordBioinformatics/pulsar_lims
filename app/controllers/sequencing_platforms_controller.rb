class SequencingPlatformsController < ApplicationController
  before_action :set_sequencing_platform, only: [:show, :edit, :update, :destroy]

  # GET /sequencing_platforms
  # GET /sequencing_platforms.json
  def index
    @sequencing_platforms = policy_scope(SequencingPlatform)
  end

  # GET /sequencing_platforms/1
  # GET /sequencing_platforms/1.json
  def show
		authorize @sequencing_platform
  end

  # GET /sequencing_platforms/new
  def new
		authorize SequencingPlatform
    @sequencing_platform = SequencingPlatform.new
  end

  # GET /sequencing_platforms/1/edit
  def edit
		authorize @sequencing_platform
  end

  # POST /sequencing_platforms
  # POST /sequencing_platforms.json
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

  # PATCH/PUT /sequencing_platforms/1
  # PATCH/PUT /sequencing_platforms/1.json
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

  # DELETE /sequencing_platforms/1
  # DELETE /sequencing_platforms/1.json
  def destroy
		authorize @sequencing_platform
    @sequencing_platform.destroy
    respond_to do |format|
      format.html { redirect_to sequencing_platforms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_platform
      @sequencing_platform = SequencingPlatform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_platform_params
      params.require(:sequencing_platform).permit(:name)
    end
end
