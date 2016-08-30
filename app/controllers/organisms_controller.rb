class OrganismsController < ApplicationController
  before_action :set_organism, only: [:show, :edit, :update, :destroy]

  # GET /organisms
  # GET /organisms.json
  def index
    @organisms = Organism.all
  end

  # GET /organisms/1
  # GET /organisms/1.json
  def show
  end

  # GET /organisms/new
  def new
    @organism = Organism.new
  end

  # GET /organisms/1/edit
  def edit
  end

  # POST /organisms
  # POST /organisms.json
  def create
    @organism = Organism.new(organism_params)

    respond_to do |format|
      if @organism.save
        format.html { redirect_to @organism, notice: 'Organism was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organism }
      else
        format.html { render action: 'new' }
        format.json { render json: @organism.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organisms/1
  # PATCH/PUT /organisms/1.json
  def update
    respond_to do |format|
      if @organism.update(organism_params)
        format.html { redirect_to @organism, notice: 'Organism was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organism.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organisms/1
  # DELETE /organisms/1.json
  def destroy
    @organism.destroy
    respond_to do |format|
      format.html { redirect_to organisms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organism
      @organism = Organism.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organism_params
      params.require(:organism).permit(:name)
    end
end
