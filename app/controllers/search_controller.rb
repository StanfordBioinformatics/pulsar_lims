class SearchController < ApplicationController
  skip_after_action :verify_authorized, only: [:search]

  def search
    limit = 10000
    @page = true # For use in pagination in view.
    query = params[:query]
    # Careful not use use 'controller_name' as a variable name as that is the name of a Rails method.
    if flash[:ctl_name].present?
      # Need to set the flash since after doing a search, the user will be within the search 
      # controller realm since a render instead of a redirect is done to get to the model-in-question's 
      # index view. Because the user can perform another search within the search controller's search 
      # view, we'll need to cache what model they used. 
      ctl_name = flash[:ctl_name]
    else
      ctl_name = params[:controller_name]
    end
    # Need to set @model_class before rendering index view since it depends on it being set.
    # Normally, it is set through the before_action callback at the top, however, we need to set it
    # based on the controler_name that is passed in the params.
    begin
      @model_class = ctl_name.classify.constantize
    rescue NameError
      @model_class = nil
    end
    # If there isn't a model class for the controller in question, then we'll get a NameError error.
    # For example, doing a search from a Welcome controller view will result in a NameError with the 
    # message "uninitialized constant Welcome". In such a case, we'll search across all Elastic indices
    # (all models). 
    if @model_class.nil?
      @records = Elasticsearch::Model.search(query, size: limit).records
      return
    elsif @model_class < ActiveRecord::Base
      @records = @model_class.search(query, size: limit).records
    else
      flash[:notice] = "Search failed; contact administrator."
      redirect_to(request.referrer || root_path)
      return
    end
    flash[:ctl_name] = ctl_name
    render "#{ctl_name}/index"
  end 
end
