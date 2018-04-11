class Api::DocumentsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/documents/3
	before_action :set_document, only: [:show]

  def find_by
    # find_by defined in ApplicationController#find_by.
    super(document_params)
  end

	def index
		@documents = policy_scope(Document).order("lower(name)")
		render json: @documents
	end

	def show
		authorize @document
		render json: @document
	end

	def create
		@document = Document.new(document_params)
		@document.user = @current_user
		authorize @document
		if @document.save
			render json: @document, status: 201
		else
			render json: { errors: @document.errors.full_messages }, status: 422
		end
	end

	private

	def set_document
		@document = Document.find(params[:id])
	end

	def document_params
		params.require(:document).permit(:name,:description)
	end
end
