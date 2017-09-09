class ConcentrationUnitsController < ApplicationController
  before_action :set_concentration_unit, only: [:show, :edit, :update, :destroy]

  def index
    @concentration_units = policy_scope(ConcentrationUnit).order("lower(name)")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @concentration_units }
    end
  end

  def show
		authorize @concentration_unit
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @concentration_unit }
    end
  end

  def new
		authorize ConcentrationUnit
    @concentration_unit = ConcentrationUnit.new
  end

  def edit
  end

  def create
		authorize ConcentrationUnit
    @concentration_unit = ConcentrationUnit.new(concentration_unit_params)
		@concentration_unit.user = current_user

    respond_to do |format|
      if @concentration_unit.save
        format.html { redirect_to @concentration_unit, notice: 'Concentration unit was successfully created.' }
        format.json { render json: @concentration_unit, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @concentration_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @concentration_unit
    respond_to do |format|
      if @concentration_unit.update(concentration_unit_params)
        format.html { redirect_to @concentration_unit, notice: 'Concentration unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @concentration_unit.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
		authorize @concentration_unit
		ddestroy(@concentration_unit,concentration_units_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concentration_unit
      @concentration_unit = ConcentrationUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concentration_unit_params
      params.require(:concentration_unit).permit(:name)
    end
end
