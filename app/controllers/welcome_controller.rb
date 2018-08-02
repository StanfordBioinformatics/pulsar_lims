class WelcomeController < ApplicationController
  skip_before_action :check_signed_in
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
  end

  def modal_for_image
    # This is to be used with AJAX to render a modal popup when a user clicks on an image link.
    @image_url = params[:image_url]
    @caption = params[:caption]
    render layout: false
  end
end
