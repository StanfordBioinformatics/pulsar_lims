class Api::SequencingRequestsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/biosamples/3
  before_action :set_biosample, only: [:show]
  skip_after_action :verify_authorized, only: [:find_by_name]

  def find_by
    #find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

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

  def sequencing_request_params
    params.require(:sequencing_request).permit(
      :user_id,
      :comment,
      :concentration,
      :concentration_unit_id,
      :name,
      :notes,
      :paired_end,
      :sample_sheet,
      :sequencing_center_id,
      :sequencing_platform_id,
      :shipped,
      :plate_ids => [],
      plates_attributes: [:id,:_destroy],
      :library_ids => [],
      libraries_attributes: [:id,:_destroy]
    )
  end

end
