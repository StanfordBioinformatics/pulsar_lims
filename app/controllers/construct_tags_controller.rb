class ConstructTagsController < ApplicationController
  before_action :set_construct_tag, only: [:show, :edit, :update, :destroy]

  def index
    @construct_tags = policy_scope(ConstructTag).order("lower(name)")
  end

  def show
		authorize @construct_tag
  end

  def new
		authorize ConstructTag
    @construct_tag = ConstructTag.new
  end

  def edit
		authorize @construct_tag
  end

  def create
		authorize ConstructTag
    @construct_tag = ConstructTag.new(construct_tag_params)

		@construct_tag.user = current_user

    respond_to do |format|
      if @construct_tag.save
        format.html { redirect_to @construct_tag, notice: 'Construct tag was successfully created.' }
        format.json { render json: @construct_tag, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @construct_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @construct_tag
    respond_to do |format|
      if @construct_tag.update(construct_tag_params)
        format.html { redirect_to @construct_tag, notice: 'Construct tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @construct_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @construct_tag
    @construct_tag.destroy
    respond_to do |format|
      format.html { redirect_to construct_tags_url }
      format.js   {head :no_content }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_construct_tag
      @construct_tag = ConstructTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def construct_tag_params
      params.require(:construct_tag).permit(:name, :description)
    end
end
