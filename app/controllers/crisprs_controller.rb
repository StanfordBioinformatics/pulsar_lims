class CrisprsController < ApplicationController
  before_action :set_crispr, only: [:show, :edit, :update, :destroy]

  # GET /crisprs
  # GET /crisprs.json
  def index
    @crisprs = Crispr.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @crisprs }
    end
  end

  # GET /crisprs/1
  # GET /crisprs/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @crispr }
    end
  end

  # GET /crisprs/new
  def new
    @crispr = Crispr.new
  end

  # GET /crisprs/1/edit
  def edit
  end

  # POST /crisprs
  # POST /crisprs.json
  def create
    @crispr = Crispr.new(crispr_params)

    respond_to do |format|
      if @crispr.save
        format.html { redirect_to @crispr, notice: 'Crispr was successfully created.' }
        format.json { render json: @crispr, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @crispr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crisprs/1
  # PATCH/PUT /crisprs/1.json
  def update
    respond_to do |format|
      if @crispr.update(crispr_params)
        format.html { redirect_to @crispr, notice: 'Crispr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @crispr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crisprs/1
  # DELETE /crisprs/1.json
  def destroy
    @crispr.destroy
    respond_to do |format|
      format.html { redirect_to crisprs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crispr
      @crispr = Crispr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crispr_params
      params.require(:crispr).permit(:name, :user_id, :crispr_construct_id, :donor_construct_id, :biosample_id)
    end
end
