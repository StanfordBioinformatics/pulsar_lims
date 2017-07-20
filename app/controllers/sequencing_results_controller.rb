class SequencingResultsController < ApplicationController
  before_action :set_sequencing_result, only: [:show, :edit, :update, :destroy]
	before_action :set_sequencing_request
	before_action :set_sequencing_run
	skip_after_action :verify_authorized, only: [:get_barcode_selector]

	def get_barcode_selector
		paired = false
		library_id = sequencing_result_params()[:library_id]
		lib = Library.find(library_id)
		paired = lib.paired_end?
		if not paired
			barcodes = lib.barcodes
			selector = '<select class="select form-control" id="sequencing_result_barcode_id">'
		else
			barcodes = lib.paired_barcodes
			selector = '<select class="select form-control" id="sequencing_result_paired_barcode_id">'
		end
		barcodes.each do |bc|
			selector += "<option value=\"#{bc.id}\">#{bc.display}</option>"
		end
		selector += '</select>'
		render text: selector
		return
	end

  def index
    @sequencing_results = policy_scope(SequencingResult)
  end

  def show
		authorize @sequencing_result
  end

  def new
		authorize SequencingResult
    @sequencing_result = @sequencing_run.sequencing_results.build
  end

  def edit
		authorize @sequencing_result
  end

  def create
		authorize SequencingResult
    @sequencing_result = @sequencing_run.sequencing_results.build(sequencing_result_params)
		lib = @sequencing_result.library
		#render text: lib.id
		#return
		@sequencing_result.user = current_user

    respond_to do |format|
      if @sequencing_result.save
        format.html { redirect_to [@sequencing_request,@sequencing_run], notice: 'Barcode sequencing result was successfully created.' }
        format.json { render json: @sequencing_result, status: :created }
      else
        format.html { render action: :new }
        format.json { render json: @sequencing_result.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @sequencing_result
    respond_to do |format|
      if @sequencing_result.update(sequencing_result_params)
        format.html { redirect_to [@sequencing_request,@sequencing_run], notice: 'Barcode sequencing result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequencing_result.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @sequencing_result
    @sequencing_result.destroy
    respond_to do |format|
      format.html { redirect_to [@sequencing_request,@sequencing_run]}
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

		def set_sequencing_run
			@sequencing_run = SequencingRRun.find(params[:sequencing_run_id])
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_result_params
      params.require(:sequencing_result).permit(:barcode_id, :paired_barcode_id, :is_control, :library_id, :comment, :read1_uri, :read2_uri, :read1_count, :read2_count)
    end
end
