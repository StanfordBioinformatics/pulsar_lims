class Api::UtilsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/utils/model_attrs
  skip_after_action :verify_authorized

  def model_attrs
    # Return the attributes of the model specified by the parameter model_name.
    model = params[:model_name].classify.constantize
    # w/o to_json call below, a dict will be returned with the key "utils" and the value being
    # the list. To get just the list, need to add this method call.
    render json: model.column_names.to_json 
  end

end
