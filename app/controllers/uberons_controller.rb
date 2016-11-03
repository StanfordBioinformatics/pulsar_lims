class UberonsController < ApplicationController
  before_action :set_uberon, only: [:show, :edit, :update, :destroy]

  # GET /uberons
  # GET /uberons.json
  def index
    @uberons = policy_scope(Uberon)
  end

  # GET /uberons/1
  # GET /uberons/1.json
  def show
		authorize @uberon
  end

  # GET /uberons/new
  def new
		authorize Uberon
    @uberon = Uberon.new
  end

  # GET /uberons/1/edit
  def edit
		authorize @uberon
  end

  # POST /uberons
  # POST /uberons.json
  def create
    @uberon = Uberon.new(uberon_params)
		authorize @uberon
		@uberon.user = current_user

    respond_to do |format|
      if @uberon.save
        format.html { redirect_to @uberon, notice: 'Uberon was successfully created.' }
        format.json { render action: 'show', status: :created, location: @uberon }
      else
        format.html { render action: 'new' }
        format.json { render json: @uberon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uberons/1
  # PATCH/PUT /uberons/1.json
  def update
		authorize @uberon
    respond_to do |format|
      if @uberon.update(uberon_params)
        format.html { redirect_to @uberon, notice: 'Uberon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @uberon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uberons/1
  # DELETE /uberons/1.json
  def destroy
		authorize @uberon
    @uberon.destroy
    respond_to do |format|
      format.html { redirect_to uberons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uberon
      @uberon = Uberon.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The uberon term you were looking for could not be found."
      redirect_to uberons_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def uberon_params
      params.require(:uberon).permit(:name, :accession)
    end
end
