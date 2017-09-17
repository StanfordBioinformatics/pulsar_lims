class Api::SequencingRequestsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosamples/3
	before_action :set_biosample, only: [:show]
	skip_after_action :verify_authorized, only: [:find_by_name]

	def show
		authorize @sequencing_request
		render json: @sequencing_request
	end

	def find_by_name
		name = params[:name]
		res = SequencingRequest.find_by(name: name)
		render json:  res
	end
	

	private

	def set_sequencing_request
		@sequencing_request = SequencingRequest.find(params[:id])
	end
end
