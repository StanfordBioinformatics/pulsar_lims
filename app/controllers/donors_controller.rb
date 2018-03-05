class DonorsController < ApplicationController
  before_action :set_donor, only: [:show, :edit, :update, :destroy]

  def index
    @records = policy_scope(Donor).order("lower(name)").page params[:page]
  end

  def show
		authorize @donor
  end

  def new
		authorize Donor
    @donor = Donor.new
  end

  def edit
		authorize @donor
  end

  def create
    @donor = Donor.new(donor_params)
		authorize @donor
		@donor.user = current_user

    respond_to do |format|
      if @donor.save
        format.html { redirect_to @donor, notice: 'Donor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @donor }
      else
        format.html { render action: 'new' }
        format.json { render json: @donor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @donor
    respond_to do |format|
      if @donor.update(donor_params)
        format.html { redirect_to @donor, notice: 'Donor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @donor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @donor
		ddestroy(@donor,donors_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donor
      @donor = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donor_params
      params.require(:donor).permit(:upstream, :name, :string)
    end
end
