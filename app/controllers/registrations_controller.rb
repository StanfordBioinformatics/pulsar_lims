class RegistrationsController < Devise::RegistrationsController
	#I'm creating this controller so that I can have it use the extra fields I added:
	# 1) first_name
	# 2) last_name
	#See article at http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html

	private

	def sign_up_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end

	def account_update_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
	end
end
