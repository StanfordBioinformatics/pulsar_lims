class PooledLibrariesController < ApplicationController
  before_action :set_pooled_library, only: [:show, :edit, :update, :destroy]

  def index
    @pooled_libraries = policy_scope(PooledLibrary).all
  end

  def show
		authorize @pooled_library
  end

  def new
		authorize PooledLibrary
    @pooled_library = PooledLibrary.new
  end

  def edit
		authorize @pooled_library
  end

  def create
		authorize PooledLibrary
    @pooled_library = PooledLibrary.new(pooled_library_params)
		@pooled_library.user = current_user

    respond_to do |format|
      if @pooled_library.save
        format.html { redirect_to @pooled_library, notice: 'Pooled library was successfully created.' }
        format.json { render json: @pooled_library, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @pooled_library.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @pooled_library
    respond_to do |format|
      if @pooled_library.update(pooled_library_params)
        format.html { redirect_to @pooled_library, notice: 'Pooled library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pooled_library.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @pooled_library
    @pooled_library.destroy
    respond_to do |format|
      format.html { redirect_to pooled_libraries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pooled_library
      @pooled_library = PooledLibrary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pooled_library_params
      params.require(:pooled_library).permit(:name, :paired_end, :sequencing_library_prep_kit_id, :size_range)
    end
end
