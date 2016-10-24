class DonorsController < ApplicationController
  before_action :set_donor, only: [:show, :edit, :update, :destroy]

  # GET /donors
  # GET /donors.json
  def index
    @donors = policy_scope(Donor)
  end

  # GET /donors/1
  # GET /donors/1.json
  def show
		authorize @donor
  end

  # GET /donors/new
  def new
		authorize Donor
    @donor = Donor.new
  end

  # GET /donors/1/edit
  def edit
		authorize @donor
  end

  # POST /donors
  # POST /donors.json
  def create
		authorize Donor
    @donor = Donor.new(donor_params)

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

  # PATCH/PUT /donors/1
  # PATCH/PUT /donors/1.json
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

  # DELETE /donors/1
  # DELETE /donors/1.json
  def destroy
		authorize @donor
    @donor.destroy
    respond_to do |format|
      format.html { redirect_to donors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donor
      @donor = Donor.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The donor you were looking for could not be found."
      redirect_to donors_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donor_params
      params.require(:donor).permit(:encode_identifier, :encode_alias, :string)
    end
end
