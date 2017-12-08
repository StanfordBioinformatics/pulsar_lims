class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = policy_scope(Document).order("lower(name)")
  end

  def show
		authorize @document
  end

  def new
		authorize Document
    @document = Document.new
  end

  def edit
		authorize @document
  end

  def create
		authorize Document
		@document = Document.new(document_params)
		@document.user = current_user

		if @document.save
			redirect_to(@document, notice: "Document was successfully created.")
		else
			render "new"
		end
	end

  def update
		authorize @document
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @document
		ddestroy(@document,documents_path)
  end

	def document
		#called by the 'show' view.
		@document = Document.find(params[:id])
		authorize @document, :show?
		send_data(data=@document.data,options={
							filename: @document.name,
							type: @document.content_type,
							disposition: 'attachment'}
		)
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
#      params.require(:document).permit(:name, :description, :content_type, :data, :document_type)
      params.require(:document).permit(:is_protocol, :document_type_id,:description,:uploaded_document,:document_id)
    end
end
