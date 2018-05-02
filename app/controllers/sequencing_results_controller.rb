class SequencingResultsController < ApplicationController
	before_action :set_sequencing_request
	before_action :set_sequencing_run
  before_action :set_sequencing_result, only: [:show, :edit, :update, :destroy]
	skip_after_action :verify_authorized, only: [:get_barcode_selector, :get_library_selector]

	def get_barcode_selector
		#Takes :library_id as a param
		library_id = params[:library_id]
		lib = Library.find(library_id)
		barcode = lib.get_indexseq
		if barcode.present?
			barcode_id = barcode.id
			barcode_display = barcode.display
		else
			barcode_id = ""
			barcode_display = ""
		end
		selector = "<option value=\"#{barcode_id}\">#{barcode_display}</option>"
		#render text: selector
		render text: barcode_id
	end

	def get_library_selector
		#Takes :barcode_id as a param, which can be a Barcode or PairedEndBarcode.
		barcode_id = params[:barcode_id]
		lib = @sequencing_request.get_library_with_barcode(barcode_id=barcode_id)
		selector = "<option value=\"#{lib.id}\">#{lib.name}</option>"
		#render text: selector
		render text: lib.id
	end

  def index
    @records = @sequencing_run.sequencing_results.page params[:page]
    policy_scope(SequencingResult)
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
				@sequencing_result.errors.full_messages.each do |msg|
					@sequencing_run.errors[:base] << msg
				end
        format.html { redirect_to [@sequencing_request,@sequencing_run] }
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
		ddestroy(@sequencing_result,polymorphic_url([@sequencing_request,@sequencing_run]))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_result
      @sequencing_result = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

		def set_sequencing_request
			@sequencing_request = set_record("SequencingRequest",params[:sequencing_request_id])
		end

		def set_sequencing_run
			@sequencing_run = set_record("SequencingRun",params[:sequencing_run_id])
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_result_params
      params.require(:sequencing_result).permit(
        :comment, 
        :is_control, 
        :library_id, 
        :notes,
        :read1_uri, 
        :read1_count, 
        :read2_uri, 
        :read2_count,
        :user_id
      )
    end
end
