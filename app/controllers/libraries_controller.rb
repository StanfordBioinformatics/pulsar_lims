class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy]

  # GET /libraries
  # GET /libraries.json
  def index
    @libraries = Library.all
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @library = Library.new(library_params)
		@library.add_documents(params[:library][:documents])

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render action: 'show', status: :created, location: @library }
      else
        format.html { render action: 'new' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
		@library.remove_documents(params[:remove_documents])
		@library.add_documents(params[:library][:documents])
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:sequence_ontology_term_id, :biosample_id, :antibody_id, :vendor_id, :lot_identifier, :vendor_product_identifier, :size_range, :strand_specificity, :name)
    end

end
