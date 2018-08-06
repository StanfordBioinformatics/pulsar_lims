class ImmunoblotsController < ApplicationController
  before_action :set_immunoblot, only: [:show, :edit, :update, :destroy, :add_gel]
  skip_after_action :verify_authorized, only: [:add_gel]

  def add_gel
    @gel = @immunoblot.build_gel({"notes": "hi"})
    @s3_direct_post = @gel.s3_direct_post()
  end

  def index
    super
  end

  def show
    authorize @immunoblot
  end

  def new
    authorize Immunoblot
    @immunoblot = Immunoblot.new
  end

  def edit
    authorize @immunoblot
  end

  def create
    authorize Immunoblot
    @immunoblot = Immunoblot.new(immunoblot_params)
    @immunoblot.user = current_user

    respond_to do |format|
      if @immunoblot.save
        format.html { redirect_to @immunoblot, notice: 'Immunoblot was successfully created.' }
        format.json { render json: @immunoblot, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @immunoblot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @immunoblot
    respond_to do |format|
      if @immunoblot.update(immunoblot_params)
        format.html { redirect_to @immunoblot, notice: 'Immunoblot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @immunoblot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@immunoblot, redirect_path_success: immunoblots_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_immunoblot
      @immunoblot = Immunoblot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def immunoblot_params
      params.require(:immunoblot).permit(
        :analyst_id, 
        :date_performed, 
        :notes,
        :primary_antibody_id,
        :primary_antibody_concentration,
        :primary_antibody_concentration_units_id,
        :secondary_antibody_id,
        :secondary_antibody_concentration,
        :secondary_antibody_concentration_units_id,
        :submitter_comments,
        document_ids: [],
        documents_attributes: [:id, :_destroy],
      )
    end
end
