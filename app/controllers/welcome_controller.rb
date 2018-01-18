class WelcomeController < ApplicationController
	skip_before_action :check_signed_in
	skip_after_action :verify_authorized
	skip_after_action :verify_policy_scoped

	def index
	end

	def search
		###AJAX call in application.js.
		query_val = params[:query_id]
		query_val.upcase! #i.e. ab-33 -> AB-33
		model_abbr = query_val.split("-")[0]
		model = ApplicationLogic::ABBR_MODEL[model_abbr]
		if model.nil?
			flash[:alert] = "Unknown Model abbreviation '#{model_abbr}'. Search for record #{query_val} failed."
			render text: request.referrer
			return
		end
		model_name = model.name

		rec = set_record(model_name,query_val)
		if rec.nil?
			flash[:alert] = "Record '#{query_val}' not found."
			render text: request.referrer
			return
		end
		render text: url_for(rec)
	end
end
