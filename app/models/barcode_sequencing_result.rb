class BarcodeSequencingResult < ActiveRecord::Base
	belongs_to :barcode	
  belongs_to :library
	belongs_to :paired_barcode
	belongs_to :user
  belongs_to :sequencing_result

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :library, presence: true
	validates_uniqueness_of :barcode, scope: [:sequencing_result, :library], message: "sequencing result already exists for the specified library and barcode.", unless: :library_paired_end?
	validates_uniqueness_of :paired_barcode, scope: [:sequencing_result, :library], message: "sequencing result already exists for the specified library and paired_barcode.", if: :library_paired_end?

	validate :barcode_valid

  def self.policy_class
    ApplicationPolicy
  end 

	def library_paired_end?
		library.paired_end?
	end

	protected
		def barcode_valid
			if paired_barcode.present? and barcode.present?
				errors[:base] << "Can't specify both paired_barcode and barcode."
			end
	
			if library_paired_end?
				if paired_barcode.present?
					if not library.paired_barcodes.include?(paired_barcode)
						errors[:base] << "Paired barcode #{paired_barcode.index1.sequence}-#{paired_barcode.index2.sequence} is not present on the library."
					end
				end
		
			else
				if barcode.present?
					if not library.barcodes.include?(barcode)
						errors[:base] << "Barcode #{barcode.sequence} is not present on the library."
					end
				end
			end
		end
end
