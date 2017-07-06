class SequencingResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :sequencing_request
	belongs_to :report, class_name: "Document"
	has_many   :barcode_sequencing_results, dependent: :destroy

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :run_name, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end

  def get_libs_without_barcode_seqresults
    libs = []
    all_libs = sequencing_request.libraries
    all_libs.each do |lib|
			barcodes = get_barcodes_on_lib_without_barcode_seqresult(lib)
      if barcodes.any?
        libs << lib 
			elsif not lib.barcoded?
				if BarcodeSequencingResult.find_by(library: lib, sequencing_result: self).blank?
				#Could be that the library isn't barcoded at all. In this case, barcodes.any? above will always be False. Thus,
				# need to add the library if not barcoded and not sequencing result exists for it on the given sequencing request.
					libs << lib
				end
      end 
    end 
    return libs
  end 

  def get_barcodes_on_lib_without_barcode_seqresult(lib)
    #returns all barcodes/paired barcodes on a given Library that don't have a BarcodeSequencingResult on the 
    # associated SequencingResult object.
    if lib.paired_end?
      barcodes = lib.paired_barcodes
    else
      barcodes = lib.barcodes
    end 
    missing_barcodes = [] #the ones to return w/o a barcode sequencing result.
    barcodes.each do |bc|
      if lib.paired_end?
        res = BarcodeSequencingResult.find_by(library: lib, sequencing_result: self, paired_barcode: bc) 
      else
        res = BarcodeSequencingResult.find_by(library: lib, sequencing_result: self, barcode: bc) 
      end 
      if res.blank?
        missing_barcodes << bc
      end 
    end 
    return missing_barcodes
  end

end
