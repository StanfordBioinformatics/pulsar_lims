class ReferenceGenomesController < ApplicationController
  before_action :set_reference_genome, only: [:show, :edit, :update, :destroy]

  # GET /reference_genomes
  # GET /reference_genomes.json
  def index
    @reference_genomes = policy_scope(ReferenceGenome)
  end

  # GET /reference_genomes/1
  # GET /reference_genomes/1.json
  def show
		authorize @reference_genome
  end

  # GET /reference_genomes/new
  def new
		authorize ReferenceGenome
    @reference_genome = ReferenceGenome.new
  end

  # GET /reference_genomes/1/edit
  def edit
		authorize @reference_genome
  end

  # POST /reference_genomes
  # POST /reference_genomes.json
  def create
		authorize ReferenceGenome
    @reference_genome = ReferenceGenome.new(reference_genome_params)

    respond_to do |format|
      if @reference_genome.save
        format.html { redirect_to @reference_genome, notice: 'Reference genome was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reference_genome }
      else
        format.html { render action: 'new' }
        format.json { render json: @reference_genome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reference_genomes/1
  # PATCH/PUT /reference_genomes/1.json
  def update
		authorize @reference_genome
    respond_to do |format|
      if @reference_genome.update(reference_genome_params)
        format.html { redirect_to @reference_genome, notice: 'Reference genome was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reference_genome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reference_genomes/1
  # DELETE /reference_genomes/1.json
  def destroy
		authorize @reference_genome
    @reference_genome.destroy
    respond_to do |format|
      format.html { redirect_to reference_genomes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference_genome
      @reference_genome = ReferenceGenome.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The reference genome you were looking for could not be found."
      redirect_to reference_genomes_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_genome_params
      params.require(:reference_genome).permit(:name, :url)
    end
end
