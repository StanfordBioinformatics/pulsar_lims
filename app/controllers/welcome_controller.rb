class WelcomeController < ApplicationController
	skip_before_action :check_signed_in

	def index
	end
end
