class SequencingResult < ActiveRecord::Base
	attr_accessor :barcode_id
	#Does not have a :name attribute, which  most other models do. Instead, the display() methods is used to show a name where
	# needed.
  belongs_to :library
	belongs_to :user
  belongs_to :sequencing_run

	validates :library, presence: true
	validates :read1_count, numericality: { greater_than: 0 }, allow_nil: true
	validates :read2_count, numericality: { greater_than: 0 }, allow_nil: true
	validates_uniqueness_of :library, message: "sequencing result already exists for this library."


	scope :persisted, lambda { where.not(id: nil) }
	validate :validate_library #make sure library is present on sequencing_request.

  def self.policy_class
    ApplicationPolicy
  end 

	def display
		barcode_seq = library.get_indexseq.sequence #returns false if not a barcoded library.
		res = library.name
		if barcode_seq
			res += " " + barcode_seq
		end
		return res
	end

	def library_paired_end?
		library.paired_end?
	end

	protected
		def validate_library
			#I think rails runs the custom validations first, so need to check below that the library was set.
			return unless self.library.present?
			if sequencing_run.sequencing_request.libraries.include?(self.library)
				return true
			end
			errors[:library] << "#{self.library.name} is not present on the sequencing request."
			return false
		end
end
