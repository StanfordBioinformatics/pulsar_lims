class BiosampleReplicatesController < ApplicationController
  before_action :set_biosample_replicate, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @biosample_replicate
  end

  def new
    authorize BiosampleReplicate
    @biosample_replicate = BiosampleReplicate.new
  end

  def edit
    authorize @biosample_replicate
  end

  def create
    authorize BiosampleReplicate
    @biosample_replicate = BiosampleReplicate.new(biosample_replicate_params)
    @biosample_replicate.user = current_user

    respond_to do |format|
      redirect = flash[:redirect]
      if not redirect.present?
        redirect = @biosample_replicate
      else
        flash[:redirect] = redirect
      end
      if @biosample_replicate.save
        format.html { redirect_to redirect, notice: 'Biosample replicate was successfully created.' }
        format.json { render json: @biosample_replicate, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @biosample_replicate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @biosample_replicate
    respond_to do |format|
      if @biosample_replicate.update(biosample_replicate_params)
        format.html { redirect_to @biosample_replicate, notice: 'Biosample replicate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @biosample_replicate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @biosample_replicate
    ddestroy(@biosample_replicate, biosample_replicates_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biosample_replicate
      @biosample_replicate = BiosampleReplicate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biosample_replicate_params
      params.require(:biosample_replicate).permit(
        :biological_replicate_number, 
        :biosample_id,
        :chipseq_experiment_id,
        :control,
        :name,
        :notes,
        :technical_replicate_number, 
        :upstream_identifier,
        :wild_type_input
      )
    end
end
