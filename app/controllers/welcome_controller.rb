class WelcomeController < ApplicationController
	skip_before_action :check_signed_in
	skip_after_action :verify_authorized
	skip_after_action :verify_policy_scoped

	def index
	end

	def search
		query_val = params[:query_id]
		model_abbr = query_val.split("-")[0]
		model_name = ApplicationLogic::ABBR_MODEL[model_abbr].name
		rec = set_record(model_name,query_val)
		render text: url_for(rec)
	end
end
