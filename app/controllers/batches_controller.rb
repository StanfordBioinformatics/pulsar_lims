class BatchesController < ApplicationController
  before_action :set_batch, only: [:show, :edit, :update, :destroy, :add_batch_item, :create_or_update_batch_item, :refresh_batch_item_row]
  skip_after_action :verify_authorized, only: [:add_batch_item, :create_or_update_batch_item, :remove_batch_item, :refresh_batch_item_row, :bulk_atacseq_index, :sn_rnaseq_index, :sc_atacseq_index, :chipseq_index]

  def bulk_atacseq_index
    title = "Batches for bulk ATAC-seq" 
    redirect_to action: index, scope: :bulk_atacseq, title: title
  end

  def sc_atacseq_index
    title = "Batches for scATAC-seq" 
    redirect_to action: index, scope: :sc_atacseq, title: title
  end
  
  def sn_rnaseq_index
    title = "Batches for snRNA-seq" 
    redirect_to action: index, scope: :sn_rnaseq, title: title
  end

  def chipseq_index
    title = "Batches for ChIP-seq"
    redirect_to action: index, scope: :chipseq, title: title
  end

  def add_batch_item
    # Called in /views/batches/show.html.erb via AJAX to add a new row for entering a
    # BatchItem.
    @batch_item = @batch.batch_items.build()
    render partial: "batches/add_batch_item", layout: false
  end

  def create_or_update_batch_item
    item_params = batch_params[:batch_items_attributes]["0"] # Subset the dict with only key being 0.
    if item_params.include?(:library_id)
      if item_params.include?(:library_attributes)
        library_attr_id = item_params[:library_attributes][:id]
        if library_attr_id != item_params[:library_id]
          # Then user changed the library selector in a batch_item row and the nested form for related library fields
          # on the related library object still reference the old library. In this case, delete library_attributes.
          item_params.delete("library_attributes")
        end
      end
    end
    if item_params[:id].present?
      # Then do an update
      @batch_item = BatchItem.find(item_params[:id])
      @batch_item.update(item_params)
    else
      # Create it
      payload = item_params
      payload.update({user_id: current_user.id})
      @batch_item = BatchItem.create(payload)
    end
    render partial: "batches/add_batch_item", layout: false
  end

  def refresh_batch_item_row
    @batch_item = BatchItem.find(params[:batch_item_id])
    render partial: "batches/add_batch_item", layout: false
  end

  def remove_batch_item
    item_id = params[:batch_item_id]
    # May be that the user never saved the batch_item (row) and just wants to remove it.
    if item_id.present?
      @batch_item = BatchItem.find(item_id)
      @batch_item.destroy!
    end
    render json: {}, status: :no_content
  end

  def index
    super
  end

  def show
    authorize @batch
  end

  def new
    authorize Batch
    scope = params[:scope]
    defaults = {}
    if scope.present?
      if scope == "sn_rnaseq"
        defaults = {batch_type: Batch::SN_RNASEQ}
      elsif scope == "sc_atacseq"
        defaults = {batch_type: Batch::SC_ATACSEQ}
      elsif scope == "bulk_atacseq"
        defaults = {batch_type: Batch::BULK_ATACSEQ}
      elsif scope == "chipseq"
        defaults = {batch_type: Batch::CHIPSEQ}
      end
    end
    @batch = Batch.new(defaults)
  end

  def edit
    authorize @batch
  end

  def create
    authorize Batch
    @batch = Batch.new(batch_params)
    @batch.user = current_user

    respond_to do |format|
      if @batch.save
        format.html { redirect_to @batch, notice: 'Batch was successfully created.' }
        format.json { render json: @batch, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @batch
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to @batch, notice: 'Batch was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @batch.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    ddestroy(@batch, redirect_path_success: batches_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def batch_params
      params.require(:batch).permit(
        :analyst_id,
        :batch_item_ids,
        :batch_type,
        :crosslinking_method,
        :date,
        :library_prototype_id,
        :notes,
        batch_items_attributes: [
          :antibody_id,
          :id,
          :biosample_id,
          :batch_id,
          :library_id,
          :notes,
          library_attributes: [                                                                          
            :id,                                                                                         
            :antibody_id,                                                                                
            :barcode_id,                                                                                 
            :concentration,
            :concentration_unit_id,
            :paired_barcode_id                                                                           
          ] 
        ]
      )
    end
end
