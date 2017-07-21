class SequencingResult < ActiveRecord::Base
	#Does not have a :name attribute, which  most other models do. Instead, the display() methods is used to show a name where
	# needed.
	belongs_to :barcode	
  belongs_to :library
	belongs_to :paired_barcode
	belongs_to :user
  belongs_to :sequencing_run

	validates :library, presence: true
	validates_uniqueness_of :barcode, scope: [:sequencing_run, :library], message: "sequencing result already exists for the specified library and barcode.", unless: :library_paired_end?
	validates_uniqueness_of :paired_barcode, scope: [:sequencing_run, :library], message: "sequencing result already exists for the specified library and paired_barcode.", if: :library_paired_end?

	#validate :barcode_valid

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
		#def barcode_valid
		#	... old code remove
		#end
end
