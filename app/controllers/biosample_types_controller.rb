class BiosampleTypesController < ApplicationController
  before_action :set_biosample_type, only: [:show, :edit, :update, :destroy]

  def select_options                                                                                   
    #Called via ajax.                                                                                  
    #Typically called when the user selects the refresh icon in any form that has a biosample_types
    # selection.   
    @records = BiosampleType.all                                                                               
    render "application_partials/select_options", layout: false                                                                               
  end 

  def index
    super
  end

  def show
		authorize @biosample_type
  end

  def new
		authorize BiosampleType
    @biosample_type = BiosampleType.new
  end

  def edit
		authorize @biosample_type
  end

  def create
    @biosample_type = BiosampleType.new(biosample_type_params)
		authorize @biosample_type
		@biosample_type.user = current_user

    respond_to do |format|
      if @biosample_type.save
        format.html { redirect_to @biosample_type, notice: 'Biosample type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @biosample_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @biosample_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @biosample_type
    respond_to do |format|
      if @biosample_type.update(biosample_type_params)
        format.html { redirect_to @biosample_type, notice: 'Biosample type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @biosample_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @biosample_type
		ddestroy(@biosample_type,biosample_types_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_biosample_type
      @biosample_type = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def biosample_type_params
      params.require(:biosample_type).permit(
        :name,
        :tissue
      )
    end
end
