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

  def add_barcodes_matrix_input(plate,barcodes)
    #barcodes is a string of barcodes in a matrix format like that of the plate, i.e. 
		#
		# CATCGA\tGTCAGT\n
		# ACGTAC\tAGGCAG\n
		# GTTACG\tCATGTC
		#
		#Alternatively the barcodes could be entered as paired-end barcodes of the form:
		#
    # CATCGA-GCATGA\tGTCAGT-TCGTAC\n
    # ACGTAC-TCGAGT\tAGGCAG-ACTAGC\n
    # GTTACG-CTACGT\tCATGTC-TTCAGC
		#
		#Barcodes in each row are delimited by a space or tab character, and rows are delimited by a newline character.	
		#The position of each barcode in the input matrix (matrix is a string here) corresponds to a well in the same position on the plate. For example, the wells represented by the barcode matrix above are
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
			row = row.split()
			row_len = row.length
			if row_len > max_row_len
				max_row_len = row_len
			end
			row
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
				col_num += 1
				bc.strip!
				bc.upcase! #Barcode sequences  are stored uppercase
				well = plate.wells.find_by({row: row_num, col: col_num})
				if well.blank?
					raise Exceptions::WellNotFoundError, "No well on plate #{plate.name} could be found with row #{row_num} and column #{col_num}."
				end
				add_barcode_to_well(plate=plate,well=well,barcode=bc)
				save_status = well.save
				if not save_status
					raise Exceptions::WellNotSavedError, "Error saving barcode #{bc} to well #{well.name}. Errors are: #{well.errors.full_messages.join('; ')}"
				end
			end
		end
		return plate
  end

	def add_barcode_to_well(plate,well,barcode)
		###
		#Args  plate - a plate instance
		#      well  - a well on the plate
		#      barcode - a single-end barcode or a paired-end barcode. Paired-end will be assumed if the barcode has a '-' inside, 
		#                i.e. ATCGAT-GCTGAC.
		prep_kit = plate.sequencing_library_prep_kit
		user = current_user
    if not plate.wells.include?(well)
			raise Exceptions::WellAndPlateMismatchError, "Well #{well.name} does not belong on plate #{plate.name}."
		end
		barcode.upcase!
		index1 = barcode
		index2 = nil
		if barcode.include?("-")
			index1,index2 = barcode.split("-")
		end
		
		index1_rec = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, sequence: index1}) 
		if index1_rec.blank?
			raise Exceptions::BarcodeNotFoundError, "Barcode #{index1} is not present in sequencing library prep kit '#{prep_kit.name}'."
		end
		if not index2 #then single-end only
			well.barcode = index1_rec
		else #then paired-end
      index2_rec = Barcode.find_by({sequencing_library_prep_kit_id: prep_kit.id,index_number: 2, sequence: index2})
      if index2_rec.blank?
        raise Exceptions::BarcodeNotFoundError, "Index2 barcode #{index2} is not present in sequencing library prep kit '#{prep_kit.name}'."
      end 
      paired_rec = PairedBarcode.find_by({sequencing_library_prep_kit_id: prep_kit.id, index1_id: index1_rec.id, index2_id: index2_rec.id})
      if paired_rec.blank? #then create it
        paired_rec = PairedBarcode.create({user: current_user, name: "#{index1_rec.name}-#{index2_rec.name}",sequencing_library_prep_kit_id: prep_kit.id, index1_id: index1_rec.id, index2_id: index2_rec.id})
      end 
      well.paired_barcode = paired_rec
		end
	end

end
