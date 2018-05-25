class BarcodeNotFoundError < StandardError
end

class Library < ActiveRecord::Base
  include ModelConcerns
  include Cloning # A Concern that includes the clone() and parent() instance methods and related ones.
  include CloningForDocuments # A Concern that includes instance methods all_documents() and parent_documents().
  ABBR = "L"
  DEFINITION = "A sequencing library that is prepared for sequencing.  Model abbreviation: #{ABBR}"
  #The is_control bool column has a default of false.
  has_many :sequencing_results, dependent: :destroy
  has_and_belongs_to_many :documents
  has_and_belongs_to_many :sequencing_requests
  has_one :single_cell_sorting, foreign_key: :library_prototype_id, dependent: :nullify
  #A virtual (prototype) library can be used as a template for a single_cell_sorting experiment. This would then be used
  # as a template for making library objects associated to the each biosample in each well of each plate present on the singe_cell_sorting. 
  belongs_to :barcode
  belongs_to :biosample
  belongs_to :concentration_unit
  belongs_to :from_prototype, class_name: "Library"
  has_many   :libraries, foreign_key: :from_prototype_id, dependent: :destroy
  has_many   :prototype_instances, class_name: "Library", foreign_key: "from_prototype_id", dependent: :restrict_with_exception
  belongs_to :library_fragmentation_method
  belongs_to :nucleic_acid_term
  belongs_to :paired_barcode
  belongs_to :sequencing_library_prep_kit
  belongs_to :user
  belongs_to :vendor
  belongs_to :well

  validates  :upstream_identifier, uniqueness: true, allow_blank: true
  validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true, presence: true
#  validates :barcode, format: { with: /\A[acgtnACGTN]+-?[acgtnACGTN]+\z/ }, allow_blank: true
  validates  :size_range, format: {with: /\A\d+-\d+\Z/}, presence: true
  validates :nucleic_acid_term_id, presence: true
  validates :documents, presence: true
  #validates :vendor_id, presence: true
  validates :biosample_id, presence: true, unless: Proc.new {|lib| lib.single_cell_sorting.present?}
  validates :concentration_unit, presence: {message: "must be specified when the quantity is specified."}, if: "concentration.present?"
  validates :concentration, presence: {message: "must be specified when the units are set."}, if: "concentration_unit.present?"
  validates :sequencing_library_prep_kit_id, presence: true

  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :sequencing_requests, allow_destroy: true
  accepts_nested_attributes_for :barcode, allow_destroy: true
  accepts_nested_attributes_for :paired_barcode, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }
  scope :non_plated, lambda { where(plated: false) }

  # Only call self.set_name() if this is a library on a well.
  before_validation :set_name, on: :create #, unless: Proc.new {|lib| lib.prototype? }
  after_validation :check_plated
  validate :validate_barcode, unless: Proc.new {|lib| lib.single_cell_sorting.present? } #verifies self.barcode/self.paired_barcode
  validate :validate_plate_consistency # If biosample belongs_to a well, make sure barcode is unique amongst all used on the plate.

  def self.policy_class
    ApplicationPolicy
  end 

  def barcoded?
    if barcode.present? or paired_barcode.present?
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
      self.paired_barcode = pb 
    end 
  end 

  def get_indexseq
    return nil unless barcoded?
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

  def clone_library(associated_biosample_id:, associated_user_id:, custom_attrs: nil)
    # Duplicates the attributes of the current library and stores them into a hash that can be used for creating a new library record
    # that looks just like the prototype. It is expected that the caller will make the specific changes
    # to distinguish this copy from the prototype, such as changing the name and user_id, for example. 
    # Some attributes don't make sense to duplicate, and hence aren't. Such attributes include 
    # the user_id (could be a different user cloning than the one that created the original), 
    # the record id, name, created_at, updated_at, upstream_identifier, and foreign keys for the biosample, any barcodes,
    # and single_cell_sorting models.
    #
    # Returns:
    #     Hash containing the attributes for creating a new library based on the passed in 
    #     prototype library. 
    #
    # Example: 
    #     This is called in /controllers/concerns/plates_concern.rb/create_library_for_well() when
    #     creating a library for an individual well, which updates the hash for things like setting
    #     the user and barcodes, then creates a library by passing in this hash as the library attributes.  
    attrs = {}
    attrs["biosample_id"] = associated_biosample_id
    attrs["from_prototype_id"] = self.id
    if custom_attrs.present?
      attrs.update(custom_attrs)
    end
    return clone(associated_user_id: associated_user_id, custom_attrs: attrs)
  end

  def attributes_for_cloning
    # Whitelist of attributes used for cloning or updating child biosamples.
    attrs = {}
    attrs["concentration"] = self.concentration
    attrs["concentration_unit_id"] = self.concentration_unit_id
    attrs["nucleic_acid_term_id"] = self.nucleic_acid_term_id
    attrs["library_fragmentation_method_id"] = self.library_fragmentation_method_id
    attrs["lot_identifier"] = self.lot_identifier
    attrs["notes"] = self.notes
    attrs["paired_end"] = self.paired_end
    attrs["plated"] = self.plated
    attrs["sequencing_library_prep_kit_id"] = self.sequencing_library_prep_kit_id
    attrs["size_range"] = self.size_range
    attrs["strand_specific"] = self.strand_specific
    attrs["vendor_id"] = self.vendor_id
    attrs["vendor_product_identifier"] = self.vendor_product_identifier
    return attrs
  end

  private

  def check_plated
    if biosample.present? and self.biosample.plated?
      self.plated = true
    else
      self.plated = false
    end
    return true
  end

  def set_name
    if self.biosample.present? #won't be if prototype library.
      if self.biosample.well.present?
        self.name = self.biosample.name
      end
    end
  end

  def validate_barcode
    return unless barcoded?

    if self.barcode.present? and self.paired_barcode.present?
      self.errors.add(:base, "Can't specify both the \"barcode\" attribute (which is used only for single-end libraries) and the \"paired_barcode\" attribute (which is used only for paired-end libraries).")
      return false
    elsif self.barcode.present? and self.paired_end?
      self.errors.add(:base, "Can't set a single-end barcode when the library is marked as paired-end. You must instead select a paired-end barcode.")
      return false
    elsif self.paired_barcode_id.present?
      if not self.paired_end?
        self.errors.add(:base, "Can't set a paired-end barcode when the library is not marked as paired-end. You must instead select a single-end barode.")
        return false
      end
    elsif self.paired_end and not self.sequencing_library_prep_kit.supports_paired_end?
      self.errors.add(:base, "Can't set paired_end to true when the sequencing library prep kit does not support paired-end sequencing.")
      return false
    end
  end

  def validate_plate_consistency
    #If the library is barcoded, and the biosample is in the well of a plate, then we need to make sure that no
    # other library on the plate has the same barcode.
    return unless self.biosample.present? and self.biosample.well.present? and self.barcoded?
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
