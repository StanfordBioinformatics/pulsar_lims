class Api::DonorConstructsController < Api::ApplicationController
  #example with curl:
  # curl -H "Authorization: Token token=${token}" http://localhost:3000/api/donor_constructs/3
  before_action :set_donor_construct, only: [:show]

  def find_by
    #find_by defined in ApplicationController#find_by.
    # Use this method when you want to AND all of your query parameters.
    super
  end

  def find_by_or
    # find_by_or defined in ApplicationController#find_by_or.
    # Use this method when you want to OR all of your query parameters.
    super
  end

  def show
    authorize @donor_construct
    render json: @donor_construct
  end

  def create
    @donor_construct = DonorConstruct.new(donor_construct_params)
    @donor_construct.user = @current_user
    authorize @donor_construct, :create?
    if @donor_construct.save
      render json: @donor_construct, status: 201
    else
      render json: { errors: @donor_construct.errors.full_messages }, status: 422
    end
  end

  private

  def set_donor_construct
    @donor_construct = DonorConstruct.find(params[:id])
  end

  def donor_construct_params
    params.require(:donor_construct).permit(
        :addgene_id,                                                                                   
        :cloning_vector_id,                                                                            
        :date_sent,                                                                                    
        :description,                                                                                  
        :donor_cell_line,                                                                              
        :ensembl_transcript,                                                                           
        :insert_sequence,                                                                              
        :known_snps,                                                                                   
        :name,                                                                                         
        :notes,                                                                                        
        :primer_left_forward,                                                                          
        :primer_left_reverse,                                                                          
        :primer_right_forward,                                                                         
        :primer_right_reverse,                                                                         
        :refseq_transcript,                                                                            
        :sent_to_id,                                                                                   
        :target_id,                                                                                    
        :vendor_id,                                                                                    
        :vendor_product_identifier,                                                                    
        :construct_tag_ids => [],                                                                      
        construct_tags_attributes: [:id, :_destroy]   
    )
  end
end
