class BiosampleTermNamesController < ApplicationController
  before_action :set_biosample_term_name, only: [:show, :edit, :update, :destroy]

  # GET /biosample_term_names
  # GET /biosample_term_names.json
  def index
    @biosample_term_names = policy_scope(BiosampleTermName)
  end

  # GET /biosample_term_names/1
  # GET /biosample_term_names/1.json
  def show
		authorize @biosample_term_name
  end

  # GET /biosample_term_names/new
  def new
		authorize BiosampleTermName
    @biosample_term_name = BiosampleTermName.new
  end

  # GET /biosample_term_names/1/edit
  def edit
		authorize @biosample_term_name
  end

  # POST /biosample_term_names
  # POST /biosample_term_names.json
  def create
		authorize BiosampleTermName 
    @biosample_term_name = BiosampleTermName.new(biosample_term_name_params)
		@biosample_term_name.user = current_user

    respond_to do |format|
      if @biosample_term_name.save
        format.html { redirect_to @biosample_term_name, notice: 'Biosample term name was successfully created.' }
        format.json { render json: @biosample_term_name, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @biosample_term_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /biosample_term_names/1
  # PATCH/PUT /biosample_term_names/1.json
  def update
		authorize @biosample_term_name
    respond_to do |format|
      if @biosample_term_name.update(biosample_term_name_params)
        format.html { redirect_to @biosample_term_name, notice: 'Biosample term name was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @biosample_term_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /biosample_term_names/1
  # DELETE /biosample_term_names/1.json
  def destroy
		authorize @biosample_term_name
    @biosample_term_name.destroy
    respond_to do |format|
      format.html { redirect_to biosample_term_names_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biosample_term_name
      @biosample_term_name = BiosampleTermName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biosample_term_name_params
      params.require(:biosample_term_name).permit(:name, :accession, :biosample_ontology_id, :description)
    end
end
