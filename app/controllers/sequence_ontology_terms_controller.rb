class SequenceOntologyTermsController < ApplicationController
  before_action :set_sequence_ontology_term, only: [:show, :edit, :update, :destroy]

  # GET /sequence_ontology_terms
  # GET /sequence_ontology_terms.json
  def index
    @sequence_ontology_terms = SequenceOntologyTerm.all
  end

  # GET /sequence_ontology_terms/1
  # GET /sequence_ontology_terms/1.json
  def show
  end

  # GET /sequence_ontology_terms/new
  def new
    @sequence_ontology_term = SequenceOntologyTerm.new
  end

  # GET /sequence_ontology_terms/1/edit
  def edit
  end

  # POST /sequence_ontology_terms
  # POST /sequence_ontology_terms.json
  def create
    @sequence_ontology_term = SequenceOntologyTerm.new(sequence_ontology_term_params)

    respond_to do |format|
      if @sequence_ontology_term.save
        format.html { redirect_to @sequence_ontology_term, notice: 'Sequence ontology term was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sequence_ontology_term }
      else
        format.html { render action: 'new' }
        format.json { render json: @sequence_ontology_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequence_ontology_terms/1
  # PATCH/PUT /sequence_ontology_terms/1.json
  def update
    respond_to do |format|
      if @sequence_ontology_term.update(sequence_ontology_term_params)
        format.html { redirect_to @sequence_ontology_term, notice: 'Sequence ontology term was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sequence_ontology_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sequence_ontology_terms/1
  # DELETE /sequence_ontology_terms/1.json
  def destroy
    @sequence_ontology_term.destroy
    respond_to do |format|
      format.html { redirect_to sequence_ontology_terms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequence_ontology_term
      @sequence_ontology_term = SequenceOntologyTerm.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The sequence ontology term you were looking for could not be found."
      redirect_to sequence_ontology_terms_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequence_ontology_term_params
      params.require(:sequence_ontology_term).permit(:name, :accession, :definition)
    end
end
