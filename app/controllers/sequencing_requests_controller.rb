class SequencingRequestsController < ApplicationController
  before_action :set_sequencing_request, only: [:show, :edit, :update, :destroy, :select_library, :select_scs, :select_scs_plates]
	before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
	skip_after_action :verify_authorized, only: [:select_library,:select_scs, :select_scs_plates]

  def select_options                                                                                   
    #Called via ajax.                                                                                  
    #Typically called when the user selects the refresh icon in any form that has a sequencing_library_prep_kits selection.
    @records = SequencingLibraryPrepKit.all                                                             
    render "application_partials/select_options", layout: false                                        
  end 

	def select_scs
		render layout: false
	end

	def select_scs_plates
		#Add plates on a Single Cell Sorting experimnt
		flash[:action] = :show
		ssc_id = params[:single_cell_sorting_selector]
		ssc = SingleCellSorting.find(ssc_id)
		@plates = ssc.plates.where.not(id: @sequencing_request.plates.persisted)
		logger.info(@plates.ids)
		#ssc_plate_ids = ssc.plate_ids
		render layout: false
	end

	def select_library
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
		flash[:action] = :show
		render layout: false
	end
		
  def index
    @records = policy_scope(SequencingRequest).page params[:page]
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
		#@sequencing_request = add_libraries(@sequencing_request,params[:sequencing_request][:library_ids])

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
		#@sequencing_request = add_libraries(@sequencing_request,params[:sequencing_request][:library_ids])
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
				action = flash[:action]
				if action.present?
					#set action for next request
					flash[:action] = action
				end
        format.html { render action || "edit" }
        format.json { render json: @sequencing_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @sequencing_request
		ddestroy(@sequencing_requests,sequencing_requests_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequencing_request
      @sequencing_request = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequencing_request_params
      params.require(:sequencing_request).permit(:sample_sheet, :concentration, :concentration_unit_id, :name,:paired_end,:comment, :sequencing_platform_id, :sequencing_center_id, :shipped, :plate_ids => [], plates_attributes: [:id,:_destroy], :library_ids => [], libraries_attributes: [:id,:_destroy])
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "sample_sheets/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
      #From the AWS docs, regarding the 201 here: If the value is set to 201, Amazon S3 returns an XML document with a 201 status code.
      #If we don't set the acl, then the file is not readable by others.
      #Also using #{SecureRandom.uuid} so that users don't overwrite an existing file with the same name. 
    end
end
