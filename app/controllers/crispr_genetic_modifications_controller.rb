class CrisprGeneticModificationsController < ApplicationController
	include DocumentsConcern #gives me add_documents()

  before_action :set_crispr_genetic_modification, only: [:show, :edit, :update, :destroy]

  # GET /crispr_genetic_modifications
  # GET /crispr_genetic_modifications.json
  def index
    @crispr_genetic_modifications = policy_scope(CrisprGeneticModification)
  end

  # GET /crispr_genetic_modifications/1
  # GET /crispr_genetic_modifications/1.json
  def show
		authorize @crispr_genetic_modification
  end

  # GET /crispr_genetic_modifications/new
  def new
		authorize CrisprGeneticModification
    @crispr_genetic_modification = CrisprGeneticModification.new
  end

  # GET /crispr_genetic_modifications/1/edit
  def edit
		authorize @crispr_genetic_modification
  end

  # POST /crispr_genetic_modifications
  # POST /crispr_genetic_modifications.json
  def create
		authorize CrisprGeneticModification
    @crispr_genetic_modification = CrisprGeneticModification.new(crispr_genetic_modification_params)
		@crispr_genetic_modification.user = current_user
		@crispr_genetic_modification = add_documents(@crispr_genetic_modification,params[:crispr_genetic_modification][:document_ids])

    respond_to do |format|
      if @crispr_genetic_modification.save
        format.html { redirect_to @crispr_genetic_modification, notice: 'Crispr genetic modification was successfully created.' }
        format.json { render json: @crispr_genetic_modification, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @crispr_genetic_modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crispr_genetic_modifications/1
  # PATCH/PUT /crispr_genetic_modifications/1.json
  def update
		authorize @crispr_genetic_modification
		@crispr_genetic_modification = add_documents(@crispr_genetic_modification,params[:crispr_genetic_modification][:document_ids])

    respond_to do |format|
      if @crispr_genetic_modification.update(crispr_genetic_modification_params)
        format.html { redirect_to @crispr_genetic_modification, notice: 'Crispr genetic modification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @crispr_genetic_modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crispr_genetic_modifications/1
  # DELETE /crispr_genetic_modifications/1.json
  def destroy
		authorize @crispr_genetic_modification
    @crispr_genetic_modification.destroy
    respond_to do |format|
      format.html { redirect_to crispr_genetic_modifications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crispr_genetic_modification
      @crispr_genetic_modification = CrisprGeneticModification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crispr_genetic_modification_params
      params.require(:crispr_genetic_modification).permit(:name,:vendor_id, :vendor_product_identifier, :guide_rna_sequences, :insert_sequence)
    end
end
