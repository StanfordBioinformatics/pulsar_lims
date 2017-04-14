module LibrariesConcern
  extend ActiveSupport::Concern
  
  private

	class BarcodeNotFoundError < StandardError
	end


  def add_libraries(model_obj,library_ids)
    """ 
    Function : Adds Libray associations to the self.libraries attr. 
    Args     : library_ids - Array of Library primary key IDs.
    """
    if library_ids.blank?
      return model_obj
		elsif library_ids.is_a?(String)
			library_ids = Array(library_ids)
    end 
    library_ids.each do |l| 
      if not l.empty?
        record = Library.find(l)
        if not model_obj.libraries.include? record
          model_obj.libraries << record
        end 
      end 
    end 
		return model_obj
  end

  def add_barcodes(model_obj,barcodes)
    #barcodes is a white-space delimited string of barcode sequences (i.e this attribute is set in a form on the library show page).
    barcodes = barcodes.split().map { |b| b if b.present? }
    prep_kit = model_obj.sequencing_library_prep_kit
    barcodes.each do |b| 
      bc = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, sequence: b}) 
      if bc.blank?
        raise BarcodeNotFoundError, "Barcode #{b} is not present in sequencing library prep kit #{prep_kit.name}."
      end 
      if model_obj.barcodes.include?(bc)
        next
      end 
      model_obj.barcodes << bc
    end 
		return model_obj
  end

	def add_paired_barcodes(model_obj,paired_barcodes)
    #paired_barcodes is a white-space delimited string of barcode sequences (i.e this attribute is set in a form on the library show page).
		user = current_user
    paired_barcodes = paired_barcodes.split().map { |b| b if b.present? }
    prep_kit = model_obj.sequencing_library_prep_kit
    paired_barcodes.each do |b| 
      index1_seq,index2_seq = b.split("-")
      index1 = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id,index_number: 1, sequence: index1_seq})
      if index1.blank?
        raise BarcodeNotFoundError, "Index1 barcode #{index1_seq} is not present in sequencing library prep kit #{prep_kit.name}."
      end 
      index2 = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id,index_number: 2, sequence: index2_seq})
      if index2.blank?
        raise BarcodeNotFoundError, "Index2 barcode #{index2_seq} is not present in sequencing library prep kit #{prep_kit.name}."
      end 
      bc = PairedBarcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, index1_id: index1.id, index2_id: index2.id})
      if bc.blank?
        bc = PairedBarcode.create({user: current_user, name: "#{index1.name}-#{index2.name}",sequencing_library_prep_kit_id: prep_kit.id, index1_id: index1.id, index2_id: index2.id})
      end 
       
      if model_obj.paired_barcodes.include?(bc)
        next
      end
      model_obj.paired_barcodes << bc
    end
		return model_obj
	end

end
