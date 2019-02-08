require 'elasticsearch/model'
class CrisprModification < ActiveRecord::Base
  #default_scope {order(:id)}
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  #Submit to the ENCODE Portal as a genetic_modification:
  # https://www.encodeproject.org/profiles/genetic_modification.json
  include ModelConcerns # A Concern.
  #crisprs only belong to biosamples.
  ABBR = "CRISPR"
  DEFINITION = "A genetic modification carried out using CRISPR technology.  This object links together one or more CRISPR Construct objects (each containing an individual guide sequence), and a Donor Construct object (containing the donor sequence). Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  belongs_to :from_prototype, class_name: "CrisprModification"
  has_many   :prototype_instances, class_name: "CrisprModification", foreign_key: "from_prototype_id", dependent: :restrict_with_exception
  belongs_to :donor_construct
  belongs_to :genomic_integration_site, class_name: "GenomeLocation"
  has_many :biosamples

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
