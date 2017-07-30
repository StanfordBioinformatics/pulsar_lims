class BarcodeNotFoundError < StandardError
end

class Library < ActiveRecord::Base
	NUCLEIC_ACID_STARTING_QUANTITY_UNITS = ["cells","cell-equivalent","µg","ng","pg","mg"]

	#The is_control bool column has a default of false.
	has_and_belongs_to_many :documents
	has_and_belongs_to_many :sequencing_requests
	has_one :single_cell_sorting, foreign_key: :library_prototype_id, dependent: :nullify
	#A virtual (prototype) library can be used as a template for a single_cell_sorting experiment. This would then be used
	# as a template for making library objects associated to the each biosample in each well of each plate present on the singe_cell_sorting. 
	belongs_to :barcode
	belongs_to :biosample
	belongs_to :from_prototype, class_name: "Library"
	has_many   :libraries, foreign_key: :from_prototype_id, dependent: :destroy
	belongs_to :library_fragmentation_method
	belongs_to :nucleic_acid_term
	belongs_to :paired_barcode
	belongs_to :sequencing_library_prep_kit
	belongs_to :user
	belongs_to :vendor
	belongs_to :well

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true, presence: true
#	validates :barcode, format: { with: /\A[acgtnACGTN]+-?[acgtnACGTN]+\z/ }, allow_blank: true
	validates  :size_range, format: {with: /\A\d+-\d+\Z/}, presence: true
	validates :nucleic_acid_term_id, presence: true
	validates :documents, presence: true
	#validates :vendor_id, presence: true
	validates :biosample_id, presence: true
	validates :nucleic_acid_starting_quantity_units, inclusion: NUCLEIC_ACID_STARTING_QUANTITY_UNITS, allow_blank: true #note that nil for string will be stored in the database as "".
	validates :nucleic_acid_starting_quantity_units, presence: {message: "must be specified when the quantity is specified."}, if: "nucleic_acid_starting_quantity.present?"
	#validates :nucleic_acid_starting_quantity, presence: true, if: "nucleic_acid_starting_quantity_units.present?", message: "Nucleic acid starting quantity must be set if the units for it are set"
	validates :nucleic_acid_starting_quantity, presence: {message: "must be specified when the units are set."}, if: "nucleic_acid_starting_quantity_units.present?"
	validates :sequencing_library_prep_kit_id, presence: true

	accepts_nested_attributes_for :documents, allow_destroy: true
	accepts_nested_attributes_for :sequencing_requests, allow_destroy: true
	accepts_nested_attributes_for :barcode, allow_destroy: true
	accepts_nested_attributes_for :paired_barcode, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	before_validation :set_name, on: :create
	validate :verify_barcode #verifies self.barcode/self.paired_barcode
	validate :verify_plate_consistency #if biosample belongs_to a well, make sure barcode is unique amongst all used on the plate.
	validate :validate_prototype
	after_update :propagate_update_if_prototype

	def self.policy_class
		ApplicationPolicy
	end 

	def barcoded?
		if paired_end? and paired_barcode.present?
			return true
		elsif not paired_end? and barcode.present?
			return true
		end
		return false
	end
		

  def barcode_id=(bid)
    if bid.present?
      barcode = Barcode.find(bid) 
      self.barcode = barcode
    end 
  end 

  def paired_barcode_id=(pbid)
    if pbid.present?
      pb = PairedBarcode.find(pbid) 
      self.paired_barcode << pb 
    end 
  end 

	def get_indexseq
		return false unless barcoded?
		if paired_end?
			return paired_barcode
		else
			return barcode
		end
	end

  def document_ids=(ids)
    """ 
    Function : Adds associations to Documents that are stored in self.documents.
    Args     : ids - array of Document IDs.
    """
    ids.each do |i| 
      if i.blank?
        next
      end 
      doc = Document.find(i)
      if not self.documents.include? doc 
        self.documents << doc 
      end 
    end 
  end

  def self.instantiate_prototype(prototype_library)
		# Args: prototype_library - A Library record with the 'prototype' attribute set to true.
		#
    #A helpler used for updating or creating a library.
    #Since the single_cell_sorting.sorting_biosample is duplicated as a 
    #starting point for creating or updating a new well biosample, several fields need to be filtered out,
    #such as the original id and well id, to name a few. When the user updates the sorting biosample,
    #all well biosamples need to be updated based on what the updated sorting biosample looks like.
    #In this case, we'll again need to call this method to filter out properties that we shouldn't explicitly
    #set.
		if not prototype_library.prototype?
			return false
		end
    library_dup = prototype_library.dup
    attrs = library_dup.attributes
		#attrs["id"] is currently nil:
		attrs["from_prototype_id"] = prototype_library.id
		attrs["document_ids"] = prototype_library.document_ids
    attrs["prototype"] = false
    #Remove attributes that shouldn't be explicitely set for the new library
    attrs.delete("name") #the name is explicitly set in the library model when it has a well associated.
    attrs.delete("id")
		attrs.delete("barcode_id")
		attrs.delete("paired_barcode_id")
		attrs.delete("biosample_id")
    attrs.delete("single_cell_sorting_id")
    attrs.delete("created_at")
    attrs.delete("updated_at")
    return attrs
	end

  def update_library_from_prototype(library_prototype)
    library_attrs = Library.instantiate_prototype(library_prototype)
    success = self.update(library_attrs)
		if not success
			raise "Unable to update library '#{self.name}': #{self.errors.full_messages}"
		end
  end 

	private

  def validate_prototype
    #A library can either be a prototype (virtual library) or an actuated library created based on a library prototype, not both.
    if self.prototype and self.from_prototype.present?
      self.errors[:base] << "Invalid: can't set both the 'prototype' and 'from_prototype' attributes."
      return false
    end 
  end

	def propagate_update_if_prototype
		#If this is a prototype library, then we need to propagate the update to dependent libraries.
		# In the case of single_cell_sorting, dependent libraries are those associated to the biosamples
		# of the wells of a plate (each well has a single biosample and such a biosample has a single library).
		# This makes updating all of the library objects with regard to all the plates on a single_cell_sorting 
		# easy to do just by changing the library prototype assocated with the single_cell_sorting.
		##if single_cell_sorting.present?
    if self.prototype?
      libraries = Library.where({from_prototype_id: self.id})
      libraries.each do |l| 
        l.update_library_from_prototype(self)
      end 
    end
	end

	def set_name
		if self.biosample.well.present?
			self.name = self.biosample.name
		end
	end

	def verify_barcode
		return unless barcoded?

		if self.barcode.present? and self.paired_barcode.present?
			self.errors.add(:base, "Can't specify both the \"barcode\" attribute (which is used only for single-end libraries) and the \"paired_barcode\" attribute (which is used only for paired-end libraries).")
			return false
		elsif self.barcode.present? and self.paired_end?
			self.errors.add(:base, "Can't set a single-end barcode when the library is marked as paired-end. You must instead select a paired-end barcode.")
			return false
		elsif self.paired_barcode.present? and not self.paired_end?
			self.errors.add(:base, "Can't set a paired-end barcode when the library is not marked as paired-end. You must instead select a single-end barode.")
			return false
		elsif self.paired_end and not self.sequencing_library_prep_kit.supports_paired_end?
			self.errors.add(:base, "Can't set paired_end to true when the sequencing library prep kit does not support paired-end sequencing.")
			return false
		end
	end

	def verify_plate_consistency
		#Called in the before_save callback.
		#If the library is barcoded, and the biosample is in the well of a plate, then we need to make sure that no
		# other library on the plate has the same barcode.
		return unless self.biosample.well.present? and self.barcoded?
		if self.persisted?
			action_term = "update"
		else
			action_term = "create"
		end
		plate_barcodes = self.biosample.well.plate.get_barcodes([self.biosample.well])
		bc = self.get_indexseq
		if plate_barcodes.include?(bc)
			self.errors.add(:base, "Can't #{action_term} library with barcode '#{bc.display}' since this barcode is present on another library for a biosample in a well on plate '#{biosample.well.plate.name}'.")
			return false
		end
	end				
				
end
