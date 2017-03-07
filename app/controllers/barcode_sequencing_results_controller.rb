class BarcodeSequencingResultsController < ApplicationController
	include BarcodeSequencingResultsHelper
  before_action :set_barcode_sequencing_result, only: [:show, :edit, :update, :destroy]
	before_action :set_sequencing_request
	before_action :set_sequencing_result

  def index
    @barcode_sequencing_results = policy_scope(BarcodeSequencingResult).order("lower(name)")
  end

  # GET /barcode_sequencing_results/1
  # GET /barcode_sequencing_results/1.json
  def show
		authorize @barcode_sequencing_result
  end

  # GET /barcode_sequencing_results/new
  def new
		authorize BarcodeSequencingResult
    @barcode_sequencing_result = @sequencing_result.barcode_sequencing_results.build
  end

  # GET /barcode_sequencing_results/1/edit
  def edit
		authorize @barcode_sequencing_result
  end

  # POST /barcode_sequencing_results
  # POST /barcode_sequencing_results.json
  def create
		authorize BarcodeSequencingResult
    @barcode_sequencing_result = @sequencing_result.barcode_sequencing_results.build(barcode_sequencing_result_params)
		lib = @barcode_sequencing_result.library
		#render text: lib.id
		#return
		@barcode_sequencing_result.user = current_user

    respond_to do |format|
			if get_libraries_on_sequencing_result(@sequencing_result).include? lib
				format.html {redirect_to [@sequencing_request,@sequencing_result], alert: "A Barcode Sequencing Result was already created for library #{lib.name}."}
      elsif @barcode_sequencing_result.save
        format.html { redirect_to [@sequencing_request,@sequencing_result], notice: 'Barcode sequencing result was successfully created.' }
        format.json { render json: @barcode_sequencing_result, status: :created }
      else
        format.html { render action: :new }
        format.json { render json: @barcode_sequencing_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /barcode_sequencing_results/1
  # PATCH/PUT /barcode_sequencing_results/1.json
  def update
		authorize @barcode_sequencing_result
    respond_to do |format|
      if @barcode_sequencing_result.update(barcode_sequencing_result_params)
        format.html { redirect_to [@sequencing_request,@sequencing_result], notice: 'Barcode sequencing result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @barcode_sequencing_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barcode_sequencing_results/1
  # DELETE /barcode_sequencing_results/1.json
  def destroy
		authorize @barcode_sequencing_result
    @barcode_sequencing_result.destroy
    respond_to do |format|
      format.html { redirect_to [@sequencing_request,@sequencing_result]}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barcode_sequencing_result
      @barcode_sequencing_result = BarcodeSequencingResult.find(params[:id])
    end

		def set_sequencing_request
			@sequencing_request = SequencingRequest.find(params[:sequencing_request_id])
		end

		def set_sequencing_result
			@sequencing_result = SequencingResult.find(params[:sequencing_result_id])
		end

    # Never trust parameters from the scary internet, only allow the white list through.
    def barcode_sequencing_result_params
      params.require(:barcode_sequencing_result).permit(:is_control, :name, :library_id, :comment, :read1_uri, :read2_uri, :read1_count, :read2_count)
    end
end
