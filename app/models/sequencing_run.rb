class SequencingRun< ActiveRecord::Base
  belongs_to :user
  belongs_to :sequencing_request
	belongs_to :report, class_name: "Document"
	has_many   :sequencing_results, dependent: :destroy

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :run_name, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end

  def get_libs_without_sequencing_results
    libs = []
    all_libs = sequencing_request.libraries
    all_libs.each do |lib|
			#barcodes = get_barcodes_on_lib_without_sequencing_results(lib)
      if barcodes.any?
        libs << lib 
			elsif not lib.barcoded?
				if BarcodeSequencingResult.find_by(library: lib, sequencing_run: self).blank?
				#Could be that the library isn't barcoded at all. In this case, barcodes.any? above will always be False. Thus,
				# need to add the library if not barcoded and not sequencing run exists for it on the given sequencing request.
					libs << lib
				end
      end 
    end 
    return libs
  end 

  def get_barcodes_on_lib_without_sequencing_results(lib)
    #returns all barcodes/paired barcodes on a given Library that don't have a BarcodeSequencingResult on the 
    # associated SequencingRun object.
    if lib.paired_end?
      barcodes = lib.paired_barcodes
    else
      barcodes = lib.barcodes
    end 
    missing_barcodes = [] #the ones to return w/o a barcode sequencing run.
    barcodes.each do |bc|
      if lib.paired_end?
        res = BarcodeSequencingResult.find_by(library: lib, sequencing_run: self, paired_barcode: bc) 
      else
        res = BarcodeSequencingResult.find_by(library: lib, sequencing_run: self, barcode: bc) 
      end 
      if res.blank?
        missing_barcodes << bc
      end 
    end 
    return missing_barcodes
  end

end
