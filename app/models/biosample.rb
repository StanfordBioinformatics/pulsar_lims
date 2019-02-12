require 'elasticsearch/model'

class Biosample < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns # A Concern
  include Cloning # A Concern that includes the clone() and parent() instance methods and related ones.
  include CloningForDocuments # A Concern that includes instance methods all_documents() and parent_documents().
  ABBR = "B"
  DEFINITION = "The source material (cell line, tissue sample) that one either begins an experiment with; also, any derivites of this source material that have been modified by the experimenter. Note: faint red rows indicate biosamples that failed (the cells_discarded attribute is set to True). Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  ###
  # Support pooled from
  ###
  has_one :chip_batch_item
  has_one :chip_batch, through: :chip_batch_item
  has_many :shippings, dependent: :destroy
  has_many :gel_lanes
  has_many :gels, through: :gel_lanes
  has_many :immunoblots, through: :gels
  has_and_belongs_to_many :pooled_from_biosamples, class_name: "Biosample", join_table: "biosamples_pooled_from_biosamples", foreign_key: "biosample_id", association_foreign_key: "pooled_from_biosample_id"
  has_and_belongs_to_many :pooled_biosamples, class_name: "Biosample", join_table: "biosamples_pooled_from_biosamples", foreign_key: "pooled_from_biosample_id", association_foreign_key: "biosample_id"

  ###
  #Add self reference so that a part_of biosample can be modelled:
  # Virtual biosamples are used currently in the single_cell_sorting model via the sorting_biosample_id foreign key.
  # This biosample is a prototype used as a reference for creating the biosamples in the wells of the plates on
  # the single_cell_sorting experiment. kk
  has_many :wt_for_chipseq_experiments, class_name: "ChipseqExperiment", foreign_key: :wild_type_control_id 
  has_many :chipseq_experiments, -> {unscope(:order)}, through: :libraries
  belongs_to :well
  has_many :biosample_parts, class_name: "Biosample", foreign_key: "part_of_id", dependent: :destroy
  belongs_to :part_of, class_name: "Biosample"
  belongs_to :from_prototype, class_name: "Biosample"
  has_many :prototype_instances, class_name: "Biosample", foreign_key: "from_prototype_id", dependent: :restrict_with_exception
  ###
  has_and_belongs_to_many :documents
  has_and_belongs_to_many :treatments
  belongs_to :crispr_modification
  belongs_to :transfected_by, class_name: "User"
  belongs_to :chipseq_starting_biosample, class_name: "ChipseqExperiment"
  #Note that specifying "dependent: :restrict_with_exception" when triggered will raise ActiveRecord::DeleteRestrictionError
  has_many :starting_biosample_single_cell_sortings, class_name: "SingleCellSorting", foreign_key: :starting_biosample_id, dependent: :restrict_with_exception #the starting biosample used for sorting. Not required.
  has_one :sorting_biosample_single_cell_sorting, class_name: "SingleCellSorting", foreign_key: :sorting_biosample_id, dependent: :nullify #, dependent: :restrict_with_error #the starting biosample used for sorting. Not required.
  belongs_to  :user
  belongs_to  :owner, class_name: "User"
  belongs_to  :biosample_term_name
  belongs_to  :biosample_type
  belongs_to  :donor
  belongs_to  :vendor
  has_many    :libraries, dependent: :destroy

  validates :replicate_number, numericality: { greater_than: 0 }, allow_nil: true
  validates :upstream_identifier, uniqueness: true, allow_blank: true
  validates :name, uniqueness: true, presence: true
  #validates :documents, presence: true, unless: Proc.new {|bio| bio.part_of_chain.any? }
  validates :biosample_type_id, presence: true
  validates :biosample_term_name_id, presence: true
  validates :vendor_id, presence: true
  validates :donor_id, presence: true
  validates :starting_amount_units, inclusion: {in: Enums::STARTING_AMOUNT_UNITS, message: "must be an element in the list #{Enums::STARTING_AMOUNT_UNITS}."}, allow_blank: true
  validates :starting_amount, presence: {message: "must be specified when the starting_amount_units is specified."}, if: "starting_amount_units.present?"
  validates :starting_amount_units, presence: {message: "must be specified when the starting_amount is specified."}, if: "starting_amount.present?"
  validates :tissue_preservation_method, inclusion: {in: Enums::TISSUE_PRESERVATION_METHODS, message: "must be an element in the list #{Enums::TISSUE_PRESERVATION_METHODS}."}, allow_blank: true
  validate :validate_not_pooled_and_part_of
  validate :validate_part_of, on: :update
  validate :validate_wild_type, on: [:create, :update]

  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :pooled_from_biosamples, allow_destroy: true
  accepts_nested_attributes_for :treatments, allow_destroy: true

  scope :non_plated, -> { where(plated: false) }
  scope :persisted, -> { where.not(id: nil) }
  scope :wild_types, -> { where(wild_type: true) }
  scope :wild_type_controls, -> {wild_types.where(control: true) }
  scope :controls, -> { where(control: true, wild_type: false) }
  scope :experimental, -> { where(wild_type: false, control: false) }
  # For scope below, self join example inspired from https://www.w3schools.com/sql/sql_join_self.asp
  scope :has_wt_parent, -> { Biosample.find_by_sql("SELECT A.* FROM biosamples A, biosamples B WHERE A.part_of_id = B.id AND B.wild_type = true AND A.wild_type = false AND A.control = False ORDER BY lower(A.name) ASC")}

  before_validation :set_name, on: [:create, :update]
  after_validation :check_plated #true if it belongs to a well.

  def self.policy_class
    ApplicationPolicy
  end

  def self.possible_biosample_terms(biosample_type)
    BiosampleTermName.all
  end

  def parents
    # Gives an array containing either the part_of biosample or the pooled_from_biosamples,
    # whichever is present. A child biosample can't be both derived via both attributes. 
    if self.part_of.present?
      return [self.part_of]
    elsif self.pooled_from_biosamples.present?
      return self.pooled_from_biosamples.to_a
    else
      return []
    end
  end

  def parent_ids
    return self.parents.map{|c| c.id}
  end

  def children
    # Gives an array containing both the biosample_parts and the pooled_biosamples.
    res = []
    if self.biosample_parts.present?
      res.concat self.biosample_parts.to_a
    end
    if self.pooled_biosamples.present?
      res.concat self.pooled_biosamples.to_a
    end
    return res
  end

  def children_ids
    return self.children.map{|c| c.id}
  end

  def control_descendents
    # Finds all descendents of the given biosample and returns an array of only the ones
    # that are controls and not wild_types, if any. 
    # Returns a Set object.
    ctls = Set.new()
    self.children.each do |c|
      if c.control? and not c.wild_type?
        ctls << c
      end
      ctls.merge(c.control_descendents())
    end
    return ctls
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

  def pooled_from_biosample_ids=(ids)
    """
    Function : Adds pooled from biosamples to self.pooled_from_biosamples.
    Args     : ids - array of Biosample IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      b = Biosample.find(i)
      next if i.to_i == self.id
      if not self.pooled_from_biosamples.include? b
        self.pooled_from_biosamples << b
      end
    end
  end

  def treatment_ids=(ids)
    """
    Function : Adds associations to Treatments that are stored in self.treatments.
    Args     : ids - array of Treatment IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      treat = Treatment.find(i)
      if not self.treatments.include? treat
        self.treatments << treat
      end
    end
  end

  def clone_biosample(associated_user_id:, custom_attrs: nil)
    # Generates a hash of attributes that can be used to duplicate the biosample. In the generated
    # attributes, the biosample property part_of_id will be set to the current biosample,
    # and the property form_prototype_id will as well.
    # Some attributes don't make sense to duplicate, and hence aren't. Such attributes include
    # the user_id (could be a different user cloning than the one that created the original),
    # record id, name, created_at, updated_at, upstream_identifier, and some foreign keys, such as well_id if present.
    # The calling code should set the user and name attributes.
    #
    # Returns:
    #     Hash containing the attributes for creating a new biosample.
    #
    # Example:
    #     This is called in the well model in the method add_biosample() to link a biosample
    #     to the well. It directly uses the hash that this method returns to create the new biosample
    #     (whose name will be set automatically in the biosample model when it sees that a well_id
    #     is set.

    attrs = {}
    attrs["part_of_id"] = self.id
    attrs["from_prototype_id"] = self.id
    if custom_attrs.present?
      attrs.update(custom_attrs)
    end
    new_clone = clone(associated_user_id: associated_user_id, custom_attrs: attrs)
    return new_clone
  end

  def attributes_for_cloning
    # Whitelist of attributes used for cloning or updating child biosamples.
    attrs = {}
    attrs["biosample_term_name_id"] = self.biosample_term_name_id
    attrs["biosample_type_id"] = self.biosample_type_id
    attrs["control"] = self.control
    attrs["crispr_modification"] = self.crispr_modification
    attrs["description"] = self.description
    attrs["date_biosample_taken"] = self.date_biosample_taken
    attrs["donor_id"] = self.donor_id
    attrs["lot_identifier"] = self.lot_identifier
    attrs["nih_institutional_certification"] = self.nih_institutional_certification
    attrs["notes"] = self.notes
    attrs["shipping_ids"] = self.shipping_ids
    attrs["tissue_preservation_method"] = self.tissue_preservation_method
    attrs["vendor_id"] = self.vendor_id
    attrs["vendor_product_identifier"] = self.vendor_product_identifier
    return attrs
  end

  def all_treatments
    """
    Returns:
        Treatment::ActiveRecord_Relation.
    """
    treatment_ids = self.treatment_ids 
    self.part_of_chain.each do |p|
      treatment_ids.concat(p.treatment_ids)
    end
    return Treatment.where(id: treatment_ids)
  end

  def parent_treatments
    return all_treatments.where.not(id: self.treatment_ids)
  end

  private

  def validate_wild_type
    if self.wild_type == true && self.crispr_modification.present?
      self.errors.add(:wild_type, "can't be set when a CRISPR modification is also set.")
      return false
    end
  end

  def validate_part_of
    # validation
    # Make sure user didn't set parent to be itself.
    if self.part_of_id == self.id
      self.errors.add(:part_of, "can't be the same as this record.")
      return false
    end
  end

  def validate_not_pooled_and_part_of
    # validation
    if self.part_of.present? and self.pooled_from_biosamples.present?
      self.errors.add(:base, "'Parent biosample' and 'Pooled from biosamples' can't both be specified.")
      return false
    end
  end

  def check_plated
    #See the Pulsar wiki page "Rails Tips", specificially the section called "Callback gotchas".
    # It's important that we return true here.
    if self.well.present?
      self.plated = true
    else
      self.plated = false
    end
    return true
  end

  def set_name
    if self.well.present?
      #A well biosample has it's own naming format
      self.name = self.well.plate.single_cell_sorting.name + " " + self.well.plate.name + " " +  self.well.get_name #(sorting exp name) + (plate name) + (well name)
    end
  end
end
