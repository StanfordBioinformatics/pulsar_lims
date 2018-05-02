class IsotypesController < ApplicationController
  before_action :set_isotype, only: [:show, :edit, :update, :destroy]

  def select_options
    #Called via ajax.
    #Typically called when the user selects the refresh icon in any form that has a isotypes selection.
    @records = Isotype.all
    render "application_partials/select_options", layout: false
  end

  def index
    @records = policy_scope(Isotype).page params[:page]
  end

  def show
		authorize @isotype
  end

  def new
		authorize Isotype
    @isotype = Isotype.new
  end

  def edit
		authorize @isotype
  end

  def create
    @isotype = Isotype.new(isotype_params)
		authorize @isotype
		@isotype.user = current_user

    respond_to do |format|
      if @isotype.save
        format.html { redirect_to @isotype, notice: 'Isotype was successfully created.' }
        format.json { render action: 'show', status: :created, location: @isotype }
      else
        format.html { render action: 'new' }
        format.json { render json: @isotype.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @isotype
    respond_to do |format|
      if @isotype.update(isotype_params)
        format.html { redirect_to @isotype, notice: 'Isotype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @isotype.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @isotype
		ddestroy(@isotype,isotypes_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_isotype
      @isotype = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def isotype_params
      params.require(:isotype).permit(:name, :notes)
    end
end
