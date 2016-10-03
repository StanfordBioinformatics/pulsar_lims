class Admin::UsersController < Admin::ApplicationController
  def index
		@users = User.order(:email)
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
end
