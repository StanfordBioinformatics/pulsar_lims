class BarcodeNotFoundError < StandardError
end

class Library < ActiveRecord::Base
	NUCLEIC_ACID_STARTING_QUANTITY_UNITS = ["cells","cell-equivalent","µg","ng","pg","mg"]

	#The is_control bool column has a default of false.
	has_many   :barcode_sequencing_results, dependent: :destroy
	has_and_belongs_to_many :documents
	has_and_belongs_to_many :sequencing_requests
	has_one :single_cell_sorting, foreign_key: :library_prototype_id, dependent: :nullify
	#A virtual (prototype) library can be used as a template for a single_cell_sorting experiment. This would then be used
	# as a template for making library objects associated to the each biosample in each well of each plate present on the singe_cell_sorting. 
	belongs_to :barcode
	belongs_to :biosample
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

	before_save :verify_barcode #verifies self.barcode/self.paired_barcode

	def self.policy_class
		ApplicationPolicy
	end 

	def barcoded?
		if paired_end? and paired_barcode.any?
			return true
		elsif not paired_end? and barcode.any?
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

	protected
		def verify_barcode
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
end
