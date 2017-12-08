class DocumentTypesController < ApplicationController
  before_action :set_document_type, only: [:show, :edit, :update, :destroy]

  def index
    @document_types = policy_scope(DocumentType).order("lower(name)")
  end

  def show
		authorize @document_type
  end

  def new
		authorize DocumentType
    @document_type = DocumentType.new
  end

  def edit
		authorize @document_type
  end

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

  def destroy
		authorize @document_type
		ddestroy(@document_type,document_types_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_type
      @document_type = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_type_params
      params.require(:document_type).permit(:name)
    end
end
