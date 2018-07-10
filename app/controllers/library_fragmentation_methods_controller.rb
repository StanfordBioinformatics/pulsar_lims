class LibraryFragmentationMethodsController < ApplicationController
  before_action :set_library_fragmentation_method, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @library_fragmentation_method
  end

  def new
    authorize LibraryFragmentationMethod
    @library_fragmentation_method = LibraryFragmentationMethod.new
  end

  def edit
  end

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

  def destroy
    ddestroy(@library_fragmentation_method, library_fragmentation_methods_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library_fragmentation_method
      @library_fragmentation_method = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_fragmentation_method_params
      params.require(:library_fragmentation_method).permit(
        :name, 
        :notes, 
       :description
      )
    end
end
