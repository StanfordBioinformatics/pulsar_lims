class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :generate_api_key, :show_api_key, :hide_api_key, :remove_api_key, :archive]
	skip_after_action :verify_authorized

  def archive
		@user.archive
    # Issue a new session identifier (http://guides.rubyonrails.org/v3.2/security.html)
		reset_session

		respond_to do |format|
			format.html { redirect_to root_path, notice: "User account was successfully removed." }
		end 
	end

	def generate_api_key
		@user.generate_api_key
		render :show
	end

	def show_api_key
		render layout: false
	end

	def remove_api_key
		@user.remove_api_key
		render :show
	end

	def show
	end

	def edit
		redirect_to :edit_user_registration
	end

	private
		def user_params
			params.require(:user).permit()
		end

		def set_user
			@user = User.find(params[:id])
			if not @user == current_user
				raise Pundit::NotAuthorizedError	
			end
		end
end
