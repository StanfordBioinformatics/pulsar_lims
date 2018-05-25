class BiosampleTermNamesController < ApplicationController
  before_action :set_biosample_term_name, only: [:show, :edit, :update, :destroy]

  def select_options
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a vendors selection
    @records = BiosampleTermName.all                                         
    render "application_partials/select_options", layout: false
  end

  def index
    super
  end

  def show
		authorize @biosample_term_name
  end

  def new
		authorize BiosampleTermName
    @biosample_term_name = BiosampleTermName.new
  end

  def edit
		authorize @biosample_term_name
  end

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

  def destroy
		authorize @biosample_term_name
		ddestroy(@biosample_term_name,biosample_term_names_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biosample_term_name
      @biosample_term_name = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb.
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biosample_term_name_params
      params.require(:biosample_term_name).permit(
        :accession, 
        :description,
        :biosample_ontology_id, 
        :name,
      )
    end
end
