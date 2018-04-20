class Biosample < ActiveRecord::Base
  include ModelConcerns
  ABBR = "B"
  DEFINITION = "The source material (cell line, tissue sample) that one either begins an experiment with; also, any derivites of this source material that have been modified by the experimenter.  Model abbreviation: #{ABBR}"
  ###
  # Support pooled from
  ###
  has_and_belongs_to_many :pooled_from_biosamples, class_name: "Biosample", join_table: "biosamples_pooled_from_biosamples", foreign_key: "biosample_id", association_foreign_key: "pooled_from_biosample_id"

  ###
  #Add self reference so that a part_of biosample can be modelled:
  #Has a 'prototype' boolean column that defaults to false. When true, means that it's a virtual biosample.
  # Virtual biosamples are used currently in the single_cell_sorting model via the sorting_biosample_id foreign key.
  # This biosample is a prototype used as a reference for creating the biosamples in the wells of the plates on
  # the single_cell_sorting experiment. kk
  belongs_to :well
  has_many :biosample_parts, class_name: "Biosample", foreign_key: "part_of_biosample_id", dependent: :destroy
  belongs_to :part_of_biosample, class_name: "Biosample"
  belongs_to :from_prototype, class_name: "Biosample"
  has_many :prototype_instances, class_name: "Biosample", foreign_key: "from_prototype_id", dependent: :destroy
  ###
  has_and_belongs_to_many :documents
  has_and_belongs_to_many :treatments
  has_one :crispr_modification, validate: true, dependent: :nullify
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

  scope :non_plated, lambda { where(plated: false, prototype: false) }
  scope :non_prototypes, lambda { where(prototype: false) }
  scope :persisted, lambda { where.not(id: nil) }

  before_validation :set_name, on: :create
  before_save :validate_prototype
  after_update :propagate_update_if_prototype
  after_validation :check_plated #true if it belongs to a well.
  #after_validation :propagate_update_if_prototype, on: :update

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

  def self.instantiate_prototype(prototype_biosample)
    #A helper used for updating or creating a well biosample.
    #Since the single_cell_sorting.sorting_biosample is duplicated as a 
    #starting point for creating or updating a new well biosample, several fields need to be filtered out,
    #such as the original id and well id, to name a few. When the user updates the sorting biosample,
    #all well biosamples need to be updated based on what the updated sorting biosample looks like.
    #In this case, we'll again need to call this method to filter out properties that we shouldn't explicitly
    #set.
    well_biosample = prototype_biosample.dup
    #well_biosample.documents = prototype_biosample.documents
    attrs = well_biosample.attributes
    #attrs["id"] is currently nil:
    attrs["from_prototype_id"] = prototype_biosample.id
    attrs["document_ids"] = prototype_biosample.document_ids
    attrs["prototype"] = false #this should always be false for a well biosample
    #Remove attributes that shouldn't be explicitely set for the well biosample
    attrs.delete("name") #the name is expicitely set in the biosample model when it has a well associated.
    attrs.delete("id")
    attrs.delete("well_id")
    attrs.delete("created_at")
    attrs.delete("updated_at")
    return attrs
  end 

  def update_biosample_from_prototype(biosample_prototype)
    biosample_attrs = Biosample.instantiate_prototype(biosample_prototype)
    success = self.update(biosample_attrs)
    if not success
      raise "Unable to update biosample '#{self.name}': #{self.errors.full_messages}"
    end
  end 

  private 

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

  def validate_prototype
    #A biosample can either be a prototype (virtual biosample) or an actuated biosample created based on a biosample prototype, not both.
    if self.prototype and self.from_prototype.present?
      self.errors[:base] << "Invalid: can't set both the 'prototype' and 'from_prototype' attributes."
      return false
    end
  end


  def propagate_update_if_prototype
    #An after_update callback.
    #If this is a prototype biosample, then we need to propagate the update to dependent biosamples.
    # In the case of single_cell_sorting, dependent biosamples are those sorted into the wells of each plate on the experiment
    # (each well has a single biosample and such a biosample has a single library).
    # This makes updating all of the biosample objects with regard to all the plates on a single_cell_sorting 
    # easy to do just by changing the biosample prototype (starting biosample) assocated with the single_cell_sorting.
    if self.prototype?
      biosamples = Biosample.where({from_prototype_id: self.id})
      biosamples.each do |b|
        b.update_biosample_from_prototype(self)
      end
    end  
#    if self.sorting_biosample_single_cell_sorting.present? 
#      sorting_biosample_single_cell_sorting.plates.each do |plate|
#        plate.wells.each do |well|
#          well.biosample.update_biosample_from_prototype(self)
#        end
#      end
#    end
  end

  def set_name
    if self.well.present?
      #A well biosample has it's own naming format
      self.name = self.well.plate.single_cell_sorting.name + " " + self.well.plate.name + " " +  self.well.get_name #(sorting exp name) + (plate name) + (well name)
    end
  end
end
