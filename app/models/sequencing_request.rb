class SequencingRequest < ActiveRecord::Base
	#There is a unique index on the compound key in the libraries_sequencing_requests join table, disallowing
	# the same library to be added twice.
	has_and_belongs_to_many :libraries
	has_and_belongs_to_many :plates
  belongs_to :sequencing_platform
  belongs_to :sequencing_center
	has_many    :sequencing_runs, dependent: :destroy
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :sequencing_center, presence: true
	validates :sequencing_platform, presence: true

	accepts_nested_attributes_for :libraries, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }
	after_update :verify_unique_barcodes

	def self.policy_class
		ApplicationPolicy
	end

	def get_barcodes(sequences=false)
		#Args : sequences - boolean. If true, then an array of barcode sequences is return rather
		# then the objects.
		barcodes = []
		libraries.each do |lib|
			bc = lib.get_indexseq()
			if bc.present?
				if sequences
					bc = bc.sequence
				end
				barcodes << bc 
			end
		end
		return barcodes
	end

	def get_library_with_barcode(barcode_id)
		if paired_end
			lib = libraries.find_by(paired_barcode_id: barcode_id)
		else
			lib = libraries.find_by(barcode_id: barcode_id)
		end
		return lib
	end

	private
		def verify_unique_barcodes
			seqs = self.get_barcodes(sequences=true)
			dups = {}
			seqs.uniq.each do |s|
				count = seqs.count(s)
				if count > 1
					dups[s] = count
				end
			end
			if dups.present?
				raise "Duplicate barcodes detected: #{dups.to_json}"
			end
		end
end
