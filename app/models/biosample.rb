class Biosample < ActiveRecord::Base
  include ModelConcerns #A Concern
  include Prototype #A Concern that includes the clone() instance method as related ones.
  ABBR = "B"
  DEFINITION = "The source material (cell line, tissue sample) that one either begins an experiment with; also, any derivites of this source material that have been modified by the experimenter.  Model abbreviation: #{ABBR}"
  ###
  # Support pooled from
  ###
  has_and_belongs_to_many :pooled_from_biosamples, class_name: "Biosample", join_table: "biosamples_pooled_from_biosamples", foreign_key: "biosample_id", association_foreign_key: "pooled_from_biosample_id"

  ###
  #Add self reference so that a part_of biosample can be modelled:
  # Virtual biosamples are used currently in the single_cell_sorting model via the sorting_biosample_id foreign key.
  # This biosample is a prototype used as a reference for creating the biosamples in the wells of the plates on
  # the single_cell_sorting experiment. kk
  belongs_to :well
  has_many :biosample_parts, class_name: "Biosample", foreign_key: "part_of_biosample_id", dependent: :destroy
  belongs_to :part_of_biosample, class_name: "Biosample"
  belongs_to :from_prototype, class_name: "Biosample"
  has_many :prototype_instances, class_name: "Biosample", foreign_key: "from_prototype_id", dependent: :restrict_with_exception
  ###
  has_and_belongs_to_many :documents
  has_and_belongs_to_many :treatments
  has_one :crispr_modification, validate: true, dependent: :destroy
  #Note that specifying "dependent: :restrict_with_exception" when triggered will raise ActiveRecord::DeleteRestrictionError
  has_many :starting_biosample_single_cell_sortings, class_name: "SingleCellSorting", foreign_key: :starting_biosample_id, dependent: :restrict_with_exception #the starting biosample used for sorting. Not required.
  has_one :sorting_biosample_single_cell_sorting, class_name: "SingleCellSorting", foreign_key: :sorting_biosample_id, dependent: :restrict_with_error #the starting biosample used for sorting. Not required.
  belongs_to  :user
  belongs_to  :owner, class_name: "User"
  belongs_to  :biosample_term_name
  belongs_to  :biosample_type
  belongs_to  :donor
  belongs_to  :vendor
  has_many    :libraries, dependent: :destroy

  validates :upstream_identifier, uniqueness: true, allow_blank: true
  #validates :name, uniqueness: true, length: { minimum: 2, maximum: 40 }, presence: true
  validates :name, uniqueness: true, presence: true
  #validates :documents, presence: true
  validates :biosample_type_id, presence: true
  validates :biosample_term_name_id, presence: true
  validates :vendor_id, presence: true
  validates :donor_id, presence: true
  validates :starting_amount_units, inclusion: {in: Enums::STARTING_AMOUNT_UNITS, message: "must be an element in the list #{Enums::STARTING_AMOUNT_UNITS}."}, allow_blank: true
  validates :starting_amount, presence: {message: "must be specified when the starting_amount_units is specified."}, if: "starting_amount_units.present?"
  validates :starting_amount_units, presence: {message: "must be specified when the starting_amount is specified."}, if: "starting_amount.present?"
  validates :tissue_preservation_method, inclusion: {in: Enums::TISSUE_PRESERVATION_METHODS, message: "must be an element in the list #{Enums::TISSUE_PRESERVATION_METHODS}."}, allow_blank: true
  validate :not_pooled_and_part_of
  validate :validate_part_of_biosample, on: :update

  accepts_nested_attributes_for :crispr_modification, allow_destroy: true
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :pooled_from_biosamples, allow_destroy: true
  accepts_nested_attributes_for :treatments, allow_destroy: true

  scope :non_plated, lambda { where(plated: false) }
  scope :persisted, lambda { where.not(id: nil) }

  before_validation :set_name, on: [:create, :update]
  after_validation :check_plated #true if it belongs to a well.
  after_update :propagate_update_if_has_biosample_parts

  def self.policy_class
    ApplicationPolicy
  end

  def self.possible_biosample_terms(biosample_type)
    BiosampleTermName.all
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
    # attributes, the biosample property part_of_biosample_id will be set to the current biosample,
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

    # Don't add "attrs["from_prototype_id"] = self.id" line that is present in the clone method of
    # other models, such as Library and CrisprModification, since cloning a Biosample can be useful
    # for other purpose than making a prototype_instance (i.e. a Biosample can be part_of another
    # Biosample, and that is the use of cloning in the case of Biosamples. Adding this attribute
    # is needed, however, in the case of cloning a sorting_biosample in a single_cell_sorting experiment,
    # thus the caller does set this attribute.

    attrs = {}
    attrs["part_of_biosample_id"] = self.id
    if custom_attrs.present?
      attrs.update(custom_attrs)
    end
    new_clone = clone(associated_user_id: associated_user_id, custom_attrs: attrs)
    if self.crispr_modification.present?   
      self.crispr_modification.clone_crispr_modification(associated_biosample_id: new_clone.id, associated_user_id: self.user.id)
    end
  end

  def attributes_for_cloning
    # Whitelist of attributes used for cloning or updating child biosamples.
    attrs = {}
    attrs["biosample_term_name_id"] = self.biosample_term_name_id
    attrs["biosample_type_id"] = self.biosample_type_id
    attrs["control"] = self.control
    attrs["description"] = self.description
    attrs["date_biosample_taken"] = self.date_biosample_taken
    attrs["donor_id"] = self.donor_id
    attrs["lot_identifier"] = self.lot_identifier
    attrs["notes"] = self.notes
    attrs["tissue_preservation_method"] = self.tissue_preservation_method
    attrs["vendor_id"] = self.vendor_id
    attrs["vendor_product_identifier"] = self.vendor_product_identifier
    return attrs
  end

  private

  def propagate_update_if_has_biosample_parts
    if self.biosample_parts.any?
      self.biosample_parts.each do |p|
        # Skip children that are also present in the prototype_instances attribute collection
        # since they should only be updated through changes in the referenced prototype. In the case of
        # single_cell_sortings, the sorting_biosample is linked to the starting_biosample via the
        # part_of_biosample property. Thus, the sorting_biosample will be present in the starting_biosample's
        # biosample_parts attribute collection and will be updated. When it is updated, it will in turn cause
        # an update in any plated biosamples through its prototype_instances attribute collection.
        next if p.from_prototype.present?
        p.update_from_sibling(sibling_id=self.id)
        # If p.prototype_instances.any? (as in the case of a sorting_biosample on a single_cell_sorting)
        # then the biosample on each well of each plate in the experiment will now be updated.
      end
    end
  end

  def parents
    parents = []
    # Add parents from any part-of relationships in this single-parent ancestor chain.
    parent = self.part_of_biosample
    while parent
      parents << parent
      parent = parent.part_of_biosample
    end

    # Add parents from any prototoype in this single-parent ancestor chain.
    # I can't imagine a scenario where it would be useful to have more than one ancestor that is
    # a prototype, but it's possible to do so should check for it.
    parent = self.from_prototype
    while parent
      parents << parent
      parent = parent.from_prototype
    end
    return parents
  end

  def all_documents
    documents = self.documents.dup # Must use dup() method here so as not to create a reference. 
    self.parents.each do |p|
      if p.documents.any?
        documents = documents.merge(p.documents)
        #The merge() method doesn't convert its argument to an array so we can still use ActiveRecord methods on it.
      end
    end
    return documents
  end

  def all_treatments
    treatments = self.treatments.dup # Must use dup() method here so as not to create a reference. 
    self.parents.each do |p|
      if p.treatments.any?
        treatments = treatments.merge(p.treatments)
        #The merge() method doesn't convert its argument to an array so we can still use ActiveRecord methods on it.
      end
    end
    return treatments
  end

  def validate_part_of_biosample
    # Make sure user didn't set parent to be itself.
    if self.part_of_biosample_id  == self.id
      self.errors.add(:part_of_biosample, "can't be the same as this record.")
      return false
    end
  end

  def not_pooled_and_part_of
    if self.part_of_biosample.present? and self.pooled_from_biosamples.present?
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
