class Api::BiosamplesController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosamples/3.json
	before_action :set_biosample

	def show
		authorize @biosample
		render json: @biosample
	end

	private

	def set_biosample
		@biosample = Biosample.find(params[:id])
	end
end
