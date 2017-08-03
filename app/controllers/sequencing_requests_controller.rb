class SequencingRequestsController < ApplicationController
	include LibrariesConcern #gives me add_libraries()
  before_action :set_sequencing_request, only: [:show, :edit, :update, :destroy]
	skip_after_action :verify_authorized, only: [:select_library]

	def select_library
		@sequencing_request = SequencingRequest.new
		exclude_libs = params[:exclude_libraries]
		if exclude_libs.present?
			if exclude_libs.is_a?(String)
				exclude_libs = Array(exclude_libs)
			end
			@exclude_library_ids = []
			exclude_libs.each do |x|
				@exclude_library_ids << x.to_i
			end
		end
				
		render layout: false
	end
		
  def index
    @sequencing_requests = policy_scope(SequencingRequest).order("lower(name)")
  end

  def show
		authorize @sequencing_request
  end

  def new
    @sequencing_request = SequencingRequest.new
		authorize @sequencing_request
  end

  def edit
		authorize @sequencing_request
  end

  def create
    @sequencing_request = SequencingRequest.new(sequencing_request_params)
		authorize @sequencing_request
		@sequencing_request.user = current_user
		@sequencing_request = add_libraries(@sequencing_request,params[:sequencing_request][:library_ids])

		begin
			saved = @sequencing_request.save
		rescue RuntimeError => e
			flash[:alert] = e.message
		end
    respond_to do |format|
      if saved
        format.html { redirect_to @sequencing_request, notice: 'Sequencing request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sequencing_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequencing_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @sequencing_request
		@sequencing_request = add_libraries(@sequencing_request,params[:sequencing_request][:library_ids])
		#render text: params
		#return
		begin
			updated = @sequencing_request.update(sequencing_request_params)
		rescue RuntimeError => e
			flash[:alert] = e.message
		end
    respond_to do |format|
      if updated
        format.html { redirect_to @sequencing_request, notice: 'Sequencing request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequencing_request.errors, status: :unprocessable_entity }
      end
    end
  end

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
      params.require(:sequencing_request).permit(:name,:paired_end,:comment, :sequencing_platform_id, :sequencing_center_id, :shipped, libraries_attributes: [:id,:_destroy])
    end
end
