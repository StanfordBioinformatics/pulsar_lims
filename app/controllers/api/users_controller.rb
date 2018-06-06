class Api::UsersController < Api::ApplicationController
  before_action :set_user, only: [:show, :edit, :generate_api_key, :hide_api_key, :remove_api_key, :archive, :unarchive]
  skip_after_action :verify_authorized

  #example with curl:                                                                                  
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/users/3           
                                                                                                       
  def find_by                                                                                          
    # find_by defined in ApplicationController#find_by.                                                
    # Use this method when you want to AND all of your query parameters.                               
    super                                                                                              
  end                                                                                                  
                                                                                                       
  def find_by_or                                                                                       
    # find_by_or defined in ApplicationController#find_by_or.                                          
    # Use this method when you want to OR all of your query parameters.                                
    super                                                                                              
  end 

  def archive
    # Params::
    #     user_id: int. The ID of the user to archive. 
    unless @user.admin?
      render json: {}, status: :forbidden
      return
    end
    archivee = User.find(params[:user_id])
    archivee.archive
    render json: {}, status: :no_content
  end

  def unarchive
    # Params::
    #     user_id: int. The ID of the user to unarchive. 
    unless @user.admin?
      render json: {}, status: :forbidden
      return
    end
    unarchivee = User.find(params[:user_id])
    unarchivee.unarchive
    render json: {}, status: :no_content
  end

  def generate_api_key
    @user.generate_api_key
    render json: {token: @user.api_key}, status: :ok
  end

  def remove_api_key
    @user.remove_api_key
    render json: {}, status: :no_content
  end

  def show
    render json: @user
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
        if not @user.admin?
          raise Pundit::NotAuthorizedError  
        end
      end
    end
end
