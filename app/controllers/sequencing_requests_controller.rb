class SequencingRequestsController < ApplicationController
	include LibrariesConcern #gives me add_libraries()
  before_action :set_sequencing_request, only: [:show, :edit, :update, :destroy]
	skip_after_action :verify_authorized, only: [:select_library]

  # GET /sequencing_requests
  # GET /sequencing_requests.json

	def select_library
		@sequencing_request = SequencingRequest.new
		render layout: false
	end
		
  def index
    @sequencing_requests = policy_scope(SequencingRequest)
  end

  # GET /sequencing_requests/1
  # GET /sequencing_requests/1.json
  def show
		authorize @sequencing_request
  end

  # GET /sequencing_requests/new
  def new
    @sequencing_request = SequencingRequest.new
		authorize @sequencing_request
  end

  # GET /sequencing_requests/1/edit
  def edit
		authorize @sequencing_request
  end

  # POST /sequencing_requests
  # POST /sequencing_requests.json
  def create
    @sequencing_request = SequencingRequest.new(sequencing_request_params)
		authorize @sequencing_request
	#	render json: params
	#	return
		@sequencing_request.user = current_user
		@sequencing_request = add_libraries(@sequencing_request,params[:sequencing_request][:library_ids])

    respond_to do |format|
      if @sequencing_request.save
        format.html { redirect_to @sequencing_request, notice: 'Sequencing request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sequencing_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequencing_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequencing_requests/1
  # PATCH/PUT /sequencing_requests/1.json
  def update
		authorize @sequencing_request
		@sequencing_request = add_libraries(@sequencing_request,params[:sequencing_request][:library_ids])
		#render text: params
		#return
    respond_to do |format|
      if @sequencing_request.update(sequencing_request_params)
        format.html { redirect_to @sequencing_request, notice: 'Sequencing request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequencing_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequencing_requests/1
  # DELETE /sequencing_requests/1.json
  def destroy
		authorize @sequencing_request
    @sequencing_request.destroy
    respond_to do |format|
      format.html { redirect_to sequencing_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_request
      @sequencing_request = SequencingRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_request_params
      params.require(:sequencing_request).permit(:name,:comment, :sequencing_platform_id, :sequencing_center_id, :shipped, libraries_attributes: [:id,:_destroy])
    end
end
