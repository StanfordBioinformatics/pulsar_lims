class WelcomeController < ApplicationController
	skip_before_action :check_signed_in
	skip_after_action :verify_authorized
	skip_after_action :verify_policy_scoped

	def index
	end

	def search
		###AJAX call in application.js.
    referrer = request.referrer

		query_val = params[:query_id]
		query_val.upcase! #i.e. ab-33 -> AB-33
		model_abbr = query_val.split("-")[0]
		model = ApplicationLogic::ABBR_MODEL[model_abbr]
		if model.nil?
			flash[:alert] = "Unknown Model abbreviation '#{model_abbr}'. Search for record #{query_val} failed."
			render text: referrer
			return
		end
		model_name = model.name
    id_val = query_val.split("-")[1] #Will be nil if index error.
    if id_val.nil?
      flash[:alert] = "Invalid search string '#{query_val}'; please see tooltip."
      render text: referrer
      return
    end

    #set_record() defined in application_controller.rb.
		rec = set_record(model_name,id_val)
		if rec.nil?
			flash[:alert] = "Record '#{query_val}' not found."
			render text: referrer
			return
		end
   
    if rec.respond_to?(:params_for_url_for) #See https://github.com/nathankw/pulsar_lims/wiki/search.
      render text: url_for(rec.params_for_url_for())
    else
      render text: url_for(rec)
    end
	end
end
