class PrimersController < ApplicationController
  before_action :set_primer, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:mate_primer_selection]

  def mate_primer_selection
    # Called via ajax in primers.js.coffee when the user is filling out the form for a Primer.
    # When the user selections a value for the Primer.direction propery, the mate_primers selection
    # should only consist of primers for the opposite direction.
    if params[:direction] == Primer::FORWARD_D
      @selection = Primer.reverse
    else
      @selection = Primer.forward
    end
    @primer = Primer.new
    render layout: false
  end

  def select_options                                                                                   
    #Called via ajax.                                                                                  
    #Typically called when the user selects the refresh icon in any form that has a primer selection.
    @records = Primer.all
    render "application_partials/select_options", layout: false                                        
  end  

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
        :ordered_from_id,
        :sequence,
        :target_id,
        :mate_primer_ids => [])
    end
end
