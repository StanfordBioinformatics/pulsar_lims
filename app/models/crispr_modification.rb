require 'elasticsearch/model'
class CrisprModification < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  #Submit to the ENCODE Portal as a genetic_modification:
  # https://www.encodeproject.org/profiles/genetic_modification.json
  include ModelConcerns # A Concern.
  include Cloning # A Concern that includes the clone() and parent() instance methods and related ones.
  #crisprs only belong to biosamples.
  ABBR = "CRISPR"
  DEFINITION = "A genetic modification carried out using CRISPR technology.  This object links together one or more CRISPR Construct objects (each containing an individual guide sequence), and a Donor Construct object (containing the donor sequence). Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :from_prototype, class_name: "CrisprModification"
  has_many   :prototype_instances, class_name: "CrisprModification", foreign_key: "from_prototype_id", dependent: :restrict_with_exception
  belongs_to :part_of, class_name: "CrisprModification"
  has_many :crispr_modification_parts, class_name: "CrisprModification", foreign_key: "part_of_id", dependent: :destroy
  belongs_to :biosample
  belongs_to :donor_construct
  belongs_to :genomic_integration_site, class_name: "GenomeLocation"

  # Each pcr_validation should be submitted to the ENCODE profile
  # https://www.encodeproject.org/profiles/genetic_modification_characterization.json.
  # This should be done after creation of the corresponding genetic_modification so that the
  # genetic_modification_characterization.characterizes property points to it.
  has_many :pcr_validations, class_name: "Pcr", dependent: :nullify
  has_and_belongs_to_many :crispr_constructs
  has_and_belongs_to_many :documents
  validates :crispr_constructs, presence: true
  validates :category, presence: true, inclusion: {in: Enums::CRISPR_MOD_CATEGORIES, message: "Must be an element from the list #{Enums::CRISPR_MOD_CATEGORIES}"}
  validates :purpose, presence: true, inclusion: {in: Enums::CRISPR_MOD_PURPOSE, message: "Must be an element from the list #{Enums::CRISPR_MOD_PURPOSE}"}
  validates :upstream_identifier, uniqueness: true, allow_blank: true
  validates :name, presence: true, uniqueness: true
  validates :biosample, presence: true
  validates :donor_construct, presence: true

  accepts_nested_attributes_for :crispr_constructs, allow_destroy: true
  accepts_nested_attributes_for :documents, allow_destroy: true 
  accepts_nested_attributes_for :genomic_integration_site, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }

  before_save :verify_target

  def self.policy_class
    ApplicationPolicy
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

  def crispr_construct_ids=(ids)
    ids.each do |i|
      if i.present?
        construct = CrisprConstruct.find(i)
        if self.crispr_constructs.include?(construct)
          next
        end
        self.crispr_constructs << construct
      end
    end
  end

  def clone_crispr_modification(associated_biosample_id:, associated_user_id:, custom_attrs: nil)
    # Generates a hash of attributes that can be used to duplicate the current genetic_modification (GM). In the generated
    # attributes, the attribute part_of_genetic_modification_id will be set to the current GM,
    # and the property from_prototype_id will as well.
    # Some attributes don't make sense to duplicate, and hence aren't. Such attributes include
    # the user_id (could be a different user cloning than the one that created the original),
    # record id, name, created_at, updated_at, upstream_identifier, and some foreign keys, such as if present.
    # The calling code should set the user and name attributes.
    #
    # Returns:
    #     Hash containing the attributes for creating a new GM.
    #
    # Example:
    attrs = {}
    attrs["part_of_id"] = self.id
    attrs["from_prototype_id"] = self.id
    attrs["biosample_id"] = associated_biosample_id
    attrs["crispr_construct_ids"] = self.crispr_construct_ids
    return clone(associated_user_id: associated_user_id, custom_attrs: attrs)
  end

  def attributes_for_cloning
    # Whitelist of attributes used for cloning or updating child biosamples.
    attrs = {}
    attrs["donor_construct_id"] = self.donor_construct_id
    attrs["description"] = self.description
    attrs["genomic_integration_site_id"] = self.genomic_integration_site_id
    attrs["category"] = self.category
    attrs["purpose"] = self.purpose
    attrs["notes"] = self.notes
    return attrs
  end

  def all_crispr_constructs
    """
    Returns:
        CrisprConstruct::ActiveRecord_Relation.
    """
    cc_ids = self.crispr_construct_ids
    self.parents.each do |p|
      cc_ids.concat(p.crispr_construct_ids)
    end
    return CrisprConstruct.where(id: cc_ids)
  end

  def parent_crispr_constructs
    return self.all_crispr_constructs.where.not(id: self.crispr_construct_ids)
  end

  def all_pcr_validations
    """
    Returns:
        PcrValidation::ActiveRecord_Relation.
    """
    ids = self.pcr_validation_ids
    self.parents.each do |p|
      ids.concat(p.pcr_validation_ids)
    end
    return Pcr.where(id: ids)
  end

  def parent_pcr_validations
    return self.all_pcr_validations.where.not(id: self.pcr_validation_ids)
  end

  private

    def verify_target
      #Verifies that all crispr_constructs and the donor_construct all have the same target specified.
      self.crispr_constructs.each do |cc|
        if cc.target.id != self.donor_construct.target.id
          self.errors.add(:target_id,"must be the same between the Crispr Construct and the Donor Construct.")
          return false
        end
      end
    end
end
