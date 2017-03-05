class LibraryFragmentationMethodsController < ApplicationController
  before_action :set_library_fragmentation_method, only: [:show, :edit, :update, :destroy]

  # GET /library_fragmentation_methods
  # GET /library_fragmentation_methods.json
  def index
    @library_fragmentation_methods = policy_scope(LibraryFragmentationMethod).order("lower(name)")
  end

  # GET /library_fragmentation_methods/1
  # GET /library_fragmentation_methods/1.json
  def show
		authorize @library_fragmentation_method
  end

  # GET /library_fragmentation_methods/new
  def new
		authorize LibraryFragmentationMethod
    @library_fragmentation_method = LibraryFragmentationMethod.new
  end

  # GET /library_fragmentation_methods/1/edit
  def edit
  end

  # POST /library_fragmentation_methods
  # POST /library_fragmentation_methods.json
  def create
		authorize @library_fragmentation_method
    @library_fragmentation_method = LibraryFragmentationMethod.new(library_fragmentation_method_params)

    respond_to do |format|
      if @library_fragmentation_method.save
        format.html { redirect_to @library_fragmentation_method, notice: 'Library fragmentation method was successfully created.' }
        format.json { render json: @library_fragmentation_method, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @library_fragmentation_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /library_fragmentation_methods/1
  # PATCH/PUT /library_fragmentation_methods/1.json
  def update
		authorize @library_fragmentation_method
    respond_to do |format|
      if @library_fragmentation_method.update(library_fragmentation_method_params)
        format.html { redirect_to @library_fragmentation_method, notice: 'Library fragmentation method was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @library_fragmentation_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /library_fragmentation_methods/1
  # DELETE /library_fragmentation_methods/1.json
  def destroy
		authorize @library_fragmentation_method
    @library_fragmentation_method.destroy
    respond_to do |format|
      format.html { redirect_to library_fragmentation_methods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library_fragmentation_method
      @library_fragmentation_method = LibraryFragmentationMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_fragmentation_method_params
      params.require(:library_fragmentation_method).permit(:name, :description)
    end
end
