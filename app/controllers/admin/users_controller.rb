class Admin::UsersController < Admin::ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
		@admins = User.where(:admin => true)
		@users = User.where(:admin => false).order(:email)
  end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: "User was successfully created." }
        format.json { render action: "index", status: :created, location: admin_users_path }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end 
    end 
  end 

	def edit
	end

	def destroy
		@user.destroy
		respond_to do |format|
			format.html { redirect_to admin_users_url, notice: "User has been deleted." }
			format.json { head :no_content }
		end
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :admin)
		end

		def set_user
			@user = User.find(params[:id])
		end
end
