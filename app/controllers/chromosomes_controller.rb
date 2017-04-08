class ChromosomesController < ApplicationController
  before_action :set_reference_genome
  before_action :set_chromosome, only: [:show, :edit, :update, :destroy]

  def show
		authorize @chromosome
  end

  def new
		authorize Chromosome
    @chromosome = @reference_genome.chromosomes.build
  end

  def edit
		authorize @chromosome
  end

  def create
		authorize Chromosome
    @chromosome = @reference_genome.chromosomes.build(chromosome_params)
		@chromosome.user = current_user

    respond_to do |format|
      if @chromosome.save
        format.html { redirect_to @reference_genome, notice: 'Chromosome was successfully created.' }
        format.json { render json: @chromosome, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @chromosome.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @chromosome
    respond_to do |format|
      if @chromosome.update(chromosome_params)
        format.html { redirect_to [@reference_genome, @chromosome], notice: 'Chromosome was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chromosome.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @chromosome
    @chromosome.destroy
    respond_to do |format|
      format.html { redirect_to @reference_genome }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
		def set_reference_genome
			@reference_genome = ReferenceGenome.find(params[:reference_genome_id])
		end

    def set_chromosome
      @chromosome = Chromosome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chromosome_params
      params.require(:chromosome).permit(:name)
    end
end
