class Api::VendorsController < Api::ApplicationController
	#example with curl:
	# curl -H "Authorization: Token token=${token}" http://localhost:3000/api/vendors/3
	before_action :set_vendor, only: [:show]

  def find_by
    # find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters. 
    super(vendor_params)
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters. 
    super(vendor_params)
  end

	def index
		@vendors = policy_scope(Vendor).order("lower(name)")
		render json: @vendors
	end

	def show
		authorize @vendor
		render json: @vendor
	end

	def create
		@vendor = Vendor.new(vendor_params)
		@vendor.user = @current_user
		authorize @vendor
		if @vendor.save
			render json: @vendor, status: 201
		else
			render json: { errors: @vendor.errors.full_messages }, status: 422
		end
	end

	private

	def set_vendor
		@vendor = Vendor.find(params[:id])
	end

	def vendor_params
		params.require(:vendor).permit(
      :upstream_identifier,                                                                          
      :name,                                                                                         
      :description,                                                                                  
      :url 
    )
	end
end
