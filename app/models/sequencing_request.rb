class SequencingRequest < ActiveRecord::Base
	DEFINITION = "Represents the type of sequencing that you will have done on one or more Libraries together. When more than one Library is added to a given Sequencing Request, then this also represents a pooled Library to be sequenced."
	ABBR = "SRES"
	#There is a unique index on the compound key in the libraries_sequencing_requests join table, disallowing
	# the same library to be added twice.
	has_and_belongs_to_many :libraries
	has_and_belongs_to_many :plates, after_remove: :remove_plate_libraries
	belongs_to :concentration_unit
  belongs_to :sequencing_platform
  belongs_to :sequencing_center
	has_many    :sequencing_runs, dependent: :destroy
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :sequencing_center, presence: true
	validates :sequencing_platform, presence: true
  validates :concentration_unit, presence: {message: "must be specified when the quantity is specified."}, if: "concentration.present?"
  validates :concentration, presence: {message: "must be specified when the units are set."}, if: "concentration_unit.present?"

	accepts_nested_attributes_for :libraries, allow_destroy: true
	accepts_nested_attributes_for :plates, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }
	validate :validate_unique_barcodes
	validate :validate_libs_have_same_kit

	def self.policy_class
		ApplicationPolicy
	end

	def plate_ids=(ids)
		return unless ids.present?
		ids.each do |i|
			next if i.blank?
			plate = Plate.find(i)
			next if self.plates.include?(plate)
			self.plates << plate 
			self.add_libraries_from_plate(plate)
		end	
	end

	def library_ids=(ids)
		return unless ids.present?
		ids.each do |i|
			next if i.blank?
			lib = Library.find(i)
			next if self.libraries.include?(lib)
			self.libraries << lib
		end	
	end

	def get_barcodes(sequences=false)
		#Args : sequences - boolean. If true, then an array of barcode sequences is returned rather
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

	protected
		def add_libraries_from_plate(plate)
			#I Set this method under the protected block so that this can be called from an instance method within the class definition.
			# Originally I had this under the private block, but that didn't allow for instance methods in the class definition
			# to call it. 
			plate.wells.each do |w|
				next if w.fail?
				lib = w.get_library()
        if lib.nil?
					raise "Error adding plates to sequencing request: No library found for well '#{w.name}' on plate '#{plate.name}' - can't be added to sequening request. If you intend to have this well empty, then go into the well and mark is as failed."
				else
					self.libraries << w.get_library()
				end
			end
		end

	private

		def remove_plate_libraries(plate)
			#Gets called after an associated plate is removed so that its libraries, which were added to self.libraries, can be also removed
			# from the sequencing_request.
			plate.get_libraries().each do |lib|
				if self.libraries.include?(lib)
					self.libraries.destroy(lib)
				end
			end
		end

		def validate_unique_barcodes
			seqs = self.get_barcodes(sequences=true)
			dups = {}
			seqs.uniq.each do |s|
				count = seqs.count(s)
				if count > 1
					dups[s] = count
				end
			end
			if dups.present?
				self.errors[:base] << "Duplicate barcodes detected. Their counts are: #{dups.to_json}"
				#raise "Duplicate barcodes detected: #{dups.to_json}"
			end
		end

		def validate_libs_have_same_kit
			libs = self.libraries
			return unless libs.any?
			prev_kit_name = libs.first.sequencing_library_prep_kit.name
			count = -1
			libs.each do |lib|
				count += 1
				kit_name = lib.sequencing_library_prep_kit.name	
				if kit_name != prev_kit_name
					self.errors[:base] << "Multiple library prep kits are present. For example, library #{lib.name} was prepared with #{kit_name}, whereas libary #{libs[count -1].name} was prepared with #{prev_kit_name}." 
					return false
					#raise "Multiple library prep kits are present. For example, library #{lib.name} was prepared with #{kit_name}, whereas libary #{libs[count -1].name} was prepared with #{prev_kit_name}." 
				end
				prev_kit_name = kit_name
			end
		end
end
