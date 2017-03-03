class DocumentTypesController < ApplicationController
  before_action :set_document_type, only: [:show, :edit, :update, :destroy]

  # GET /document_types
  # GET /document_types.json
  def index
    @document_types = policy_scope(DocumentType).order("lower(name)")
  end

  # GET /document_types/1
  # GET /document_types/1.json
  def show
		authorize @document_type
  end

  # GET /document_types/new
  def new
		authorize DocumentType
    @document_type = DocumentType.new
  end

  # GET /document_types/1/edit
  def edit
		authorize @document_type
  end

  # POST /document_types
  # POST /document_types.json
  def create
    @document_type = DocumentType.new(document_type_params)
		authorize @document_type
		@document_type.user = current_user

    respond_to do |format|
      if @document_type.save
        format.html { redirect_to @document_type, notice: 'Document type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @document_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_types/1
  # PATCH/PUT /document_types/1.json
  def update
		authorize @document_type
    respond_to do |format|
      if @document_type.update(document_type_params)
        format.html { redirect_to @document_type, notice: 'Document type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
  def destroy
		authorize @document_type
    @document_type.destroy
    respond_to do |format|
      format.html { redirect_to document_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_type
      @document_type = DocumentType.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The document type you were looking for could not be found."
      redirect_to document_types_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_type_params
      params.require(:document_type).permit(:name)
    end
end
