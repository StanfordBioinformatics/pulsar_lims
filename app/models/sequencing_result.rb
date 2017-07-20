class BarcodeSequencingResult < ActiveRecord::Base
	belongs_to :barcode	
  belongs_to :library
	belongs_to :paired_barcode
	belongs_to :user
  belongs_to :sequencing_run

	validates :library, presence: true
	validates_uniqueness_of :barcode, scope: [:sequencing_run, :library], message: "sequencing result already exists for the specified library and barcode.", unless: :library_paired_end?
	validates_uniqueness_of :paired_barcode, scope: [:sequencing_run, :library], message: "sequencing result already exists for the specified library and paired_barcode.", if: :library_paired_end?

	validate :barcode_valid

	scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 

	def display
		seq = get_barcode_sequence
		if not seq
			return library.name
		else
			return "#{library.name} #{seq}"
		end
	end

	def get_barcode_sequence
		if not library.barcoded?
			return nil
		end

		if library_paired_end?
			return paired_barcode.get_sequence
		else
			return barcode.sequence
		end
	end

	def library_paired_end?
		library.paired_end?
	end

	protected
		def barcode_valid
			if paired_barcode.present? and barcode.present?
				errors[:base] << "Can't specify both paired_barcode and barcode."
				return
			end
	
			if library_paired_end?
				if paired_barcode.present?
					if not library.paired_barcodes.include?(paired_barcode)
						errors[:base] << "Paired barcode #{paired_barcode.index1.sequence}-#{paired_barcode.index2.sequence} is not present on the library."
						return
					end
					if sequencing_run.sequencing_results.find_by({library_id: library.id, paired_barcode_id: paired_barcode.id}).present?
						errors[:base] << "A barcode sequencing result object already exists for library #{library.name} and paired barcode #{paired_barcode.display}."
						return
					end
				end
		
			else
				if barcode.present?
					if not library.barcodes.include?(barcode)
						errors[:base] << "Barcode #{barcode.sequence} is not present on the library."
						return
					end
					if sequencing_run.sequencing_results.find_by({library_id: library.id, barcode_id: barcode.id}).present?
						errors[:base] << "A barcode sequencing result object already exists for library #{library.name} and barcode #{barcode.display}."
					end
				end
			end
		end
end
