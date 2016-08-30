class HumanGenesController < ApplicationController
  before_action :set_human_gene, only: [:show, :edit, :update, :destroy]

  # GET /human_genes
  # GET /human_genes.json
  def index
    @human_genes = HumanGene.all
  end

  # GET /human_genes/1
  # GET /human_genes/1.json
  def show
  end

  # GET /human_genes/new
  def new
    @human_gene = HumanGene.new
  end

  # GET /human_genes/1/edit
  def edit
  end

  # POST /human_genes
  # POST /human_genes.json
  def create
    @human_gene = HumanGene.new(human_gene_params)

    respond_to do |format|
      if @human_gene.save
        format.html { redirect_to @human_gene, notice: 'Human gene was successfully created.' }
        format.json { render action: 'show', status: :created, location: @human_gene }
      else
        format.html { render action: 'new' }
        format.json { render json: @human_gene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /human_genes/1
  # PATCH/PUT /human_genes/1.json
  def update
    respond_to do |format|
      if @human_gene.update(human_gene_params)
        format.html { redirect_to @human_gene, notice: 'Human gene was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @human_gene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /human_genes/1
  # DELETE /human_genes/1.json
  def destroy
    @human_gene.destroy
    respond_to do |format|
      format.html { redirect_to human_genes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_human_gene
      @human_gene = HumanGene.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def human_gene_params
      params.require(:human_gene).permit(:encode_identifier, :name)
    end
end
