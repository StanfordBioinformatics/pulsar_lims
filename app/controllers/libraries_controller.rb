class LibrariesController < ApplicationController
	#include DocumentsConcern #gives me add_documents()
  before_action :set_library, only: [:show, :edit, :update, :destroy]
	skip_after_action :verify_authorized, only: [:select_barcode,:select_paired_barcode]

  def select_barcode
    #barcodes on a sequencing_library_prep_kit
		#used in the Library _form with ajax
		@library = Library.new
		kit_id = library_params()[:sequencing_library_prep_kit_id]
		kit = SequencingLibraryPrepKit.find(kit_id)
		@index1_barcodes = Barcode.where({sequencing_library_prep_kit_id: kit.id, index_number: 1})
    render layout: false
  end

  def select_paired_barcode
    #barcodes on a sequencing_library_prep_kit
		#used in the Library _form with ajax
		@library = Library.new
		kit_id = library_params()[:sequencing_library_prep_kit_id]
		kit = SequencingLibraryPrepKit.find(kit_id)
		@paired_barcodes = PairedBarcode.where({sequencing_library_prep_kit_id: kit.id})
    render layout: false
  end

  def index
    @libraries = policy_scope(Library).order("lower(name)")
  end

  def show
		authorize @library
  end

  def new
		authorize Library
    @library = Library.new
  end

  def edit
		authorize @library	
  end

  def create
		authorize Library
#		render json: params
#		return
    @library = Library.new(library_params)

		@library.user = current_user

		#@library = add_documents(@library,params[:library][:document_ids])

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render action: 'show', status: :created, location: @library }
      else
        format.html { render action: 'new' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @library
#		render json: params[:library]
#		return

		#@library = remove_documents(@library,params[:remove_documents])
		#@library = add_documents(@library,params[:library][:document_ids])

    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @library
    @library.destroy
    respond_to do |format|
      format.html { redirect_to libraries_url, notice: "Library has been deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The library you were looking for could not be found."
      redirect_to libraries_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:from_prototype, :prototype, :paired_end, :sequencing_library_prep_kit_id, :library_fragmentation_method_id, :nucleic_acid_starting_quantity, :nucleic_acid_starting_quantity_units, :is_control, :nucleic_acid_term_id, :biosample_id, :vendor_id, :lot_identifier, :vendor_product_identifier, :size_range, :strand_specific, :name, :barcode_id, :paired_barcode_id, :document_ids => [], documents_attributes: [:id,:_destroy], sequencing_requests_attributes: [:id,:_destroy], barcode_attributes: [:id,:_destroy], paired_barcode_attributes: [:id, :_destroy])
    end

end
