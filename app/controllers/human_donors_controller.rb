class HumanDonorsController < ApplicationController
  before_action :set_human_donor, only: [:show, :edit, :update, :destroy]

  # GET /human_donors
  # GET /human_donors.json
  def index
    @human_donors = HumanDonor.all
  end

  # GET /human_donors/1
  # GET /human_donors/1.json
  def show
  end

  # GET /human_donors/new
  def new
    @human_donor = HumanDonor.new
  end

  # GET /human_donors/1/edit
  def edit
  end

  # POST /human_donors
  # POST /human_donors.json
  def create
    @human_donor = HumanDonor.new(human_donor_params)

    respond_to do |format|
      if @human_donor.save
        format.html { redirect_to @human_donor, notice: 'Human donor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @human_donor }
      else
        format.html { render action: 'new' }
        format.json { render json: @human_donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /human_donors/1
  # PATCH/PUT /human_donors/1.json
  def update
    respond_to do |format|
      if @human_donor.update(human_donor_params)
        format.html { redirect_to @human_donor, notice: 'Human donor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @human_donor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /human_donors/1
  # DELETE /human_donors/1.json
  def destroy
    @human_donor.destroy
    respond_to do |format|
      format.html { redirect_to human_donors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_human_donor
      @human_donor = HumanDonor.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The human donor you were looking for could not be found."
      redirect_to human_donors_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def human_donor_params
      params.require(:human_donor).permit(:encode_identifier, :encode_alias, :string)
    end
end
