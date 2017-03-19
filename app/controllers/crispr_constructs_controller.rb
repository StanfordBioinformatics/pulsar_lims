class CrisprConstructsController < ApplicationController
  before_action :set_crispr_construct, only: [:show, :edit, :update, :destroy]

  def index
    @crispr_constructs = policy_scope(CrisprConstruct).order("lower(name)")
  end

  def show
		authorize @crispr_construct	
  end

  def new
		authorize CrisprConstruct
    @crispr_construct = CrisprConstruct.new
  end

  def edit
		authorize @crispr_construct
  end

  def create
		authorize CrisprConstruct
    @crispr_construct = CrisprConstruct.new(crispr_construct_params)

		@crispr_construct.user = current_user

    respond_to do |format|
      if @crispr_construct.save
        format.html { redirect_to @crispr_construct, notice: 'Crispr construct was successfully created.' }
        format.json { render json: @crispr_construct, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @crispr_construct.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @crispr_construct
    respond_to do |format|
      if @crispr_construct.update(crispr_construct_params)
        format.html { redirect_to @crispr_construct, notice: 'Crispr construct was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @crispr_construct.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @crispr_construct
    @crispr_construct.destroy
    respond_to do |format|
      format.html { redirect_to crispr_constructs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crispr_construct
      @crispr_construct = CrisprConstruct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crispr_construct_params
      params.require(:crispr_construct).permit(:name, :target_id, :guide_sequence, :cloning_vector_id, :description, :vendor_id, :vendor_product_identifier)
    end
end
