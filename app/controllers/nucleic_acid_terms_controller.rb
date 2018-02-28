class NucleicAcidTermsController < ApplicationController
  before_action :set_nucleic_acid_term, only: [:show, :edit, :update, :destroy]

  def index
    @nucleic_acid_terms = policy_scope(NucleicAcidTerm).order("lower(name)").page params[:page]
  end

  def show
		authorize @nucleic_acid_term
  end

  def new
		authorize NucleicAcidTerm
    @nucleic_acid_term = NucleicAcidTerm.new
  end

  def edit
		authorize @nucleic_acid_term
  end

  def create
    @nucleic_acid_term = NucleicAcidTerm.new(nucleic_acid_term_params)
		authorize @nucleic_acid_term
		@nucleic_acid_term.user = current_user

    respond_to do |format|
      if @nucleic_acid_term.save
        format.html { redirect_to @nucleic_acid_term, notice: 'nucleic acid term was successfully created.' }
        format.json { render action: 'show', status: :created, location: @nucleic_acid_term }
      else
        format.html { render action: 'new' }
        format.json { render json: @nucleic_acid_term.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @nucleic_acid_term
    respond_to do |format|
      if @nucleic_acid_term.update(nucleic_acid_term_params)
        format.html { redirect_to @nucleic_acid_term, notice: 'nucleic acid term was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @nucleic_acid_term.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @nucleic_acid_term
		ddestroy(@nucleic_acid_term,nucleic_acid_terms_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nucleic_acid_term
      @nucleic_acid_term = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nucleic_acid_term_params
      params.require(:nucleic_acid_term).permit(:name, :accession, :definition)
    end
end
