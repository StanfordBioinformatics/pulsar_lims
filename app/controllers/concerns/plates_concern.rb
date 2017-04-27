module PlatesConcern
  extend ActiveSupport::Concern
  
  private
	
	def create_wells(plate)
		rows = plate.nrow
		cols = plate.ncol
		(1..rows).each do |r|
			(1..cols).each do |c|
				plate.wells.build({user: plate.user, row: r, col: c})
			end
		end
	end

  def add_barcodes(plate,barcodes)
    #barcodes is a string of barcodes in a matrix format like that of the plate, i.e. 
		#"""
		# CATCGA\tGTCAGT\n
		# ACGTAC\tAGGCAG\n
		# GTTACG\tCATGTC
		#
		#Barcodes in each row are delimited by a tab character, and rows are delimited by a newline character.	
		#Each barcode corresponds to a well in the same position on the plate. For example, the wells represented by the barcode matrix above are
		# A1 A2
 		# B1 B2
		# C1 C2

    prep_kit = plate.sequencing_library_prep_kit
    barcodes_rows = barcodes.split("\n")
		num_rows = barcodes_rows.length
		#check for more rows than the plate
		if num_rows > plate.nrow
			raise Exceptions::TooManyRowsError, "You have entered #{num_rows} but the plate only has #{plate.nrow} rows."
		end
		max_row_len = 0
		barcodes_rows.map! do |row|
			row = row.split("\t")
			row_len = row.length
			if row_len > max_row_len
				max_row_len = row_len
			end
		end
		#check for any rows having more columns than the plate
		if max_row_len > plate.ncol
			raise Exceptions::TooManyColumnsError, "You have entered 1 or more rows with more columns than contained in the plate (#{plate.ncol})."
		end
				
		row_num = 0
		barcodes_rows.each do |row|
			row_num += 1
			col_num = 0
			row.each do |bc|
				bc.upcase! #Barcode sequences  are stored uppercase
				col_num += 1
				bc = bc.strip()
				well = plate.wells.find_by({row: row_num, col: col_num})
      	bc = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, sequence: bc}) 
	      if bc.blank?
 	       raise Exceptions::BarcodeNotFoundError, "Barcode #{b} is not present in sequencing library prep kit #{prep_kit.name}."
				end
				well.barcode = bc
			end
		end
		return plate
  end

	def add_paired_barcodes(plate,paired_barcodes)
    #paired_barcodes is a white-space delimited string of barcode sequences (i.e this attribute is set in a form on the plate show page).
		user = current_user
    paired_barcodes = paired_barcodes.split().map { |b| b if b.present? }
    prep_kit = plate.sequencing_library_prep_kit
    paired_barcodes.each do |b| 
      index1_seq,index2_seq = b.split("-")
      index1 = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id,index_number: 1, sequence: index1_seq})
      if index1.blank?
        raise Exceptions::BarcodeNotFoundError, "Index1 barcode #{index1_seq} is not present in sequencing library prep kit #{prep_kit.name}."
      end 
      index2 = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id,index_number: 2, sequence: index2_seq})
      if index2.blank?
        raise Exceptions::BarcodeNotFoundError, "Index2 barcode #{index2_seq} is not present in sequencing library prep kit #{prep_kit.name}."
      end 
      bc = PairedBarcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, index1_id: index1.id, index2_id: index2.id})
      if bc.blank?
        bc = PairedBarcode.create({user: current_user, name: "#{index1.name}-#{index2.name}",sequencing_library_prep_kit_id: prep_kit.id, index1_id: index1.id, index2_id: index2.id})
      end 
       
      if plate.paired_barcodes.include?(bc)
        next
      end
      plate.paired_barcodes << bc
    end
		return plate
	end

end
