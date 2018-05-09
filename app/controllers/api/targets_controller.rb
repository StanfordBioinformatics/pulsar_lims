class Api::TargetsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/targets/3
	before_action :set_target, only: [:show]

  def find_by
    # find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

	def index
		@targets = policy_scope(Target).order("lower(name)")
		render json: @targets
	end

	def show
		authorize @target
		render json: @target
	end

	def create
		@target = Target.new(target_params)
		@target.user = @current_user
		authorize @target
		if @target.save
			render json: @target, status: :created
		else
			render json: { errors: @target.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def set_target
		@target = Target.find(params[:id])
	end

	def target_params
		params.require(:target).permit(
      :ensembl,
      :name,
      :notes,
      :refseq,
      :uniprotkb,
      :upstream_identifier
    )
	end
end
