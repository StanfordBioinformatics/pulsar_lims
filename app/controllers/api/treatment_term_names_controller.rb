class Api::TreatmentTermNamesController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/treatment_term_names/3
	before_action :set_treatment_term_name, only: [:show]

  def find_by
    # find_by defined in ApplicationController#find_by.
    super(treatment_term_name_params)
  end

	def index
		@treatment_term_names = policy_scope(TreatmentTermName).order("lower(name)")
		render json: @treatment_term_names
	end

	def show
		authorize @treatment_term_name
		render json: @treatment_term_name
	end

	def create
		@treatment_term_name = TreatmentTermName.new(treatment_term_name_params)
		@treatment_term_name.user = @current_user
		authorize @treatment_term_name
		if @treatment_term_name.save
			render json: @treatment_term_name, status: 201
		else
			render json: { errors: @treatment_term_name.errors.full_messages }, status: 422
		end
	end

	private

	def set_treatment_term_name
		@treatment_term_name = TreatmentTermName.find(params[:id])
	end

  def treatment_term_name_params                                                                     
    params.require(:treatment_term_name).permit(                                                     
      :accession,                                                                                    
      :description,                                                                                  
      :name                                                                                          
    )                                                                                                
  end
end
