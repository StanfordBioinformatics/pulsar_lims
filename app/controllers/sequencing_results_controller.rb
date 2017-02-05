class SequencingResultsController < ApplicationController
  before_action :set_sequencing_result, only: [:show, :edit, :update, :destroy, :library_result]
	before_action :set_sequencing_request
	skip_after_action :verify_authorized, only: [:library_result]

  # GET /sequencing_results
  # GET /sequencing_results.json

	def library_result
		@library_sequencing_result = @sequencing_result.library_sequencing_results.build	
		render layout: false
		return
	end

  def index
    @sequencing_results = policy_scope(SequencingResult)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sequencing_results }
    end
  end

  # GET /sequencing_results/1
  # GET /sequencing_results/1.json
  def show
		authorize @sequencing_result
  end

  # GET /sequencing_results/new
  def new
    @sequencing_result = @sequencing_request.build_sequencing_result
		authorize @sequencing_result
  end

  # GET /sequencing_results/1/edit
  def edit
		authorize @sequencing_result
  end

  # POST /sequencing_results
  # POST /sequencing_results.json
  def create
    @sequencing_result = @sequencing_request.build_sequencing_result(sequencing_result_params)
		authorize @sequencing_result
		@sequencing_result.user = current_user

    respond_to do |format|
      if @sequencing_result.save
        format.html { redirect_to [@sequencing_request,@sequencing_result], notice: 'Sequencing result was successfully created.' }
        format.json { render json: @sequencing_result, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequencing_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequencing_results/1
  # PATCH/PUT /sequencing_results/1.json
  def update
		authorize @sequencing_result
    respond_to do |format|
      if @sequencing_result.update(sequencing_result_params)
        format.html { redirect_to [@sequencing_request,@sequencing_result], notice: 'Sequencing result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequencing_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequencing_results/1
  # DELETE /sequencing_results/1.json
  def destroy
		authorize @sequencing_result
    @sequencing_result.destroy
    respond_to do |format|
      format.html { redirect_to @sequencing_request}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_result
      @sequencing_result = SequencingResult.find(params[:id])
    end

		def set_sequencing_request
			@sequencing_request = SequencingRequest.find(params[:sequencing_request_id])
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_result_params
      params.require(:sequencing_result).permit(:name, :sequencing_request_id, :run_name, :lane, :comment)
    end
end
