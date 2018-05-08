class ReferenceGenomesController < ApplicationController
  before_action :set_reference_genome, only: [:show, :edit, :update, :destroy]

  def index
    super(ReferenceGenome)
  end

  def show
		authorize @reference_genome
  end

  def new
		authorize ReferenceGenome
    @reference_genome = ReferenceGenome.new
  end

  def edit
		authorize @reference_genome
  end

  def create
    @reference_genome = ReferenceGenome.new(reference_genome_params)
		authorize @reference_genome
		@reference_genome.user = current_user

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

  def destroy
		authorize @reference_genome
		ddestroy(@reference_genome,reference_genomes_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference_genome
      @reference_genome = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_genome_params
      params.require(:reference_genome).permit(
        :name, 
        :notes,
        :url
      )
    end
end
