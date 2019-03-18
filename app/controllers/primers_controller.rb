class PrimersController < ApplicationController
  before_action :set_primer, only: [:show, :edit, :update, :destroy]

  def index
    super
  end

  def show
    authorize @primer
  end

  def new
    authorize Primer
    @primer = Primer.new
  end

  def edit
    authorize @primer
  end

  def create
    authorize Primer
    @primer = Primer.new(primer_params)
    @primer.user = current_user 

    respond_to do |format|
      if @primer.save
        format.html { redirect_to @primer, notice: 'Primer was successfully created.' }
        format.json { render json: @primer, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @primer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @primer
    respond_to do |format|
      if @primer.update(primer_params)
        format.html { redirect_to @primer, notice: 'Primer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @primer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@primer, redirect_path_success: primers_path) 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_primer
      @primer = Primer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def primer_params
      params.require(:primer).permit(
        :date_ordered,
        :description,
        :designed_by_id,
        :direction,
        :melting_temperature,
        :name, 
        :notes,
        :sequence,
        :target_id)
    end
end
