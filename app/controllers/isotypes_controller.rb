class IsotypesController < ApplicationController
  before_action :set_isotype, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /isotypes
  # GET /isotypes.json
  def index
    @isotypes = policy_scope(Isotype)
  end

  # GET /isotypes/1
  # GET /isotypes/1.json
  def show
		authorize @isotype
  end

  # GET /isotypes/new
  def new
		authorize Isotype
    @isotype = Isotype.new
  end

  # GET /isotypes/1/edit
  def edit
		authorize @isotype
  end

  # POST /isotypes
  # POST /isotypes.json
  def create
		authorize Isotype
    @isotype = Isotype.new(isotype_params)

    respond_to do |format|
      if @isotype.save
        format.html { redirect_to @isotype, notice: 'Isotype was successfully created.' }
        format.json { render action: 'show', status: :created, location: @isotype }
      else
        format.html { render action: 'new' }
        format.json { render json: @isotype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /isotypes/1
  # PATCH/PUT /isotypes/1.json
  def update
		authorize @isotype
    respond_to do |format|
      if @isotype.update(isotype_params)
        format.html { redirect_to @isotype, notice: 'Isotype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @isotype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /isotypes/1
  # DELETE /isotypes/1.json
  def destroy
		authorize @isotype
    @isotype.destroy
    respond_to do |format|
      format.html { redirect_to isotypes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_isotype
      @isotype = Isotype.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The isotype you were looking for could not be found."
      redirect_to isotypes_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def isotype_params
      params.require(:isotype).permit(:name)
    end
end
