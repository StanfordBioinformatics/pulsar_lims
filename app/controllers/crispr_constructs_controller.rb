class CrisprConstructsController < ApplicationController
  before_action :set_crispr_construct, only: [:show, :edit, :update, :destroy]
  skip_after_action :verify_authorized, only: [:select_construct_tag]

  def select_construct_tag
    @crispr_construct = CrisprConstruct.new
    exclude_construct_tags = params[:exclude_construct_tags]
    if exclude_construct_tags.present?
      if exclude_construct_tags.is_a?(String)
        exclude_construct_tags = Array(exclude_construct_tags)
      end 
      @construct_tags = ConstructTag.where.not(id: [exclude_construct_tags])  
    else
      @construct_tags = ConstructTag.all
    end 
        
    render layout: false
  end 

  def index
    super
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
    ddestroy(@crispr_construct, crispr_constructs_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crispr_construct
      @crispr_construct = set_record(controller_name,params[:id]) #set_record defined in application_controller.rb
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crispr_construct_params
      params.require(:crispr_construct).permit(
        :addgene_id, 
        :cloning_vector_id, 
        :date_sent,
        :description, 
        :ensembl_transcript, 
        :guide_sequence, 
        :name, 
        :notes,
        :refseq_transcript, 
        :sent_to_id,
        :target_id, 
        :vendor_id, 
        :vendor_product_identifier, 
        construct_tags_attributes: [:id,:_destroy],
        :construct_tag_ids => []
      )
    end
end
