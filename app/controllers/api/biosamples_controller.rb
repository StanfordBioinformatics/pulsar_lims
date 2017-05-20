class Api::BiosamplesController < Api::ApplicationController
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
