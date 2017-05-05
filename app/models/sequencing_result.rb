class SequencingResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :sequencing_request
	belongs_to :report, class_name: "Document"
	has_many   :barcode_sequencing_results, dependent: :destroy

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :run_name, presence: true

	def self.policy_class
		ApplicationPolicy
	end

  def missing_barcode_sequencing_results?
    libs = sequencing_request.libraries
    libs.each do |lib|
      barcodes = get_barcodes_on_lib_without_barcode_seqresult(lib)
      if barcodes.any?
        return true
      end 
    end 
    return false
  end

  def get_libs_without_barcode_seqresults
    libs = []
    all_libs = sequencing_request.libraries
    all_libs.each do |lib|
			barcodes = get_barcodes_on_lib_without_barcode_seqresult(lib)
      if barcodes.any?
        libs << lib 
      end 
    end 
    return libs
  end 

  def get_barcodes_on_lib_without_barcode_seqresult(lib)
    #returns all barcodes/paired barcodes on a given Library that don't have a BarcodeSequencingResult on the 
    # associated SequencingResult object.
    if sequencing_request.paired_end?
      barcodes = lib.paired_barcodes
    else
      barcodes = lib.barcodes
    end 
    missing_barcodes = [] #the ones to return w/o a barcode sequencing result.
    barcodes.each do |bc|
      if sequencing_request.paired_end?
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
