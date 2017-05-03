class PairedBarcodesController < ApplicationController
  before_action :set_paired_barcode, only: [:show, :edit, :update, :destroy]

  def index
    @paired_barcodes = policy_scope(PairedBarcode).order("lower(name)")
  end

  def show
		authorize @paired_barcode
  end

  def new
		authorize PairedBarcode
    @paired_barcode = PairedBarcode.new
  end

  def edit
  end

  def create
		authorize PairedBarcode
    @paired_barcode = PairedBarcode.new(paired_barcode_params)
		#@paired_barcode.user = current_user
		user = current_user

		prep_kit_id = paired_barcode_params[:sequencing_library_prep_kit_id]
		if prep_kit_id.blank?
			redirect_to new_paired_barcode_path, alert: "Sequencing library prep kit can't be blank."
			return
		end
		prep_kit = SequencingLibraryPrepKit.find(prep_kit_id)
		
		pb_text = paired_barcode_params[:add_paired_barcodes].split("\n")
		create_count = 0
		pb_text.each do |line|
			line.strip!
			index1_seq,index2_seq = line.split("-") #the sequences
			index1_seq.strip!
			index2_seq.strip!
			index1 = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, sequence: index1_seq, index_number: 1})

			if index1.blank?
				redirect_to new_paired_barcode_path, alert: "Index1 barcode in pair #{line} does not exist in sequencing library prep kit #{prep_kit.name}. Make sure you provided the correct orientation and didn't reverse complement it"
				return
			end

			index2 = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, sequence: index2_seq,index_number: 2})
			if index2.blank?
        redirect_to new_paired_barcode_path, alert: "Index2 barcode in pair #{line} does not exist in sequencing library prep kit #{prep_kit.name}. Make sure you provided the correct orientation and didn't reverse complement it."
				return
			end
			name = PairedBarcode.make_name(index1.name,index2.name)
			#check if paired_barcode exists already by this name in the specified kit
			existing_pb_rec = PairedBarcode.find_by(name: name)
			if existing_pb_rec.present?
				next
			end
			PairedBarcode.create!({name: name, user_id: user.id, sequencing_library_prep_kit_id: prep_kit.id, index1_id: index1.id, index2_id: index2.id})
			create_count += 1
		end


   #format.json { render json: @paired_barcode, status: :created }
    respond_to do |format|
			if create_count > 0
				notice = "Paired barcodes were successfully created."
			else
				notice = "No new paired-barcodes were created as the input ones already existed or none were specified."
			end
      format.html { redirect_to new_paired_barcode_path, notice: notice }
    end
  end

  def update
		authorize @paired_barcode
    respond_to do |format|
      if @paired_barcode.update(paired_barcode_params)
        format.html { redirect_to @paired_barcode, notice: 'Paired barcode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paired_barcode.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @paired_barcode
    @paired_barcode.destroy
    respond_to do |format|
      format.html { redirect_to paired_barcodes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paired_barcode
      @paired_barcode = PairedBarcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paired_barcode_params
      params.require(:paired_barcode).permit(:add_paired_barcodes, :index1_id, :index2_id, :sequencing_library_prep_kit_id)
    end
end
