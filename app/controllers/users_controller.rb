class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :generate_api_key, :show_api_key, :remove_api_key]
	skip_after_action :verify_authorized

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
	end

	def update
		if params[:user][:password].blank?
			params[:user].delete(:password)
		end
		
		respond_to do |format|
			if @user.update(user_params)
				format.html { redirect_to admin_users_path, notice: "User was successfully updated."}
				format.json { head :no_content }
			else
				format.html { render :edit }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end
				
	private
		def user_params
			params.require(:user).permit(:email, :password, :role)
		end

		def set_user
			@user = User.find(params[:id])
			if not @user == current_user
				raise Pundit::NotAuthorizedError	
			end
		end
end
