class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @unit
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unit }
    end
  end

  def new
    authorize Unit
    @unit = Unit.new
  end

  def edit
  end

  def create
    authorize Unit
    @unit = Unit.new(unit_params)
    @unit.user = current_user

    respond_to do |format|
      if @unit.save
        format.html { redirect_to @unit, notice: 'Unit was successfully created.' }
        format.json { render json: @unit, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @unit
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to @unit, notice: 'Unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    ddestroy(@unit, redirect_path_success: units_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(
        :name,
        :unit_type
      )
    end
end
