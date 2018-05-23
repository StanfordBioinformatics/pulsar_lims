class CrisprModification < ActiveRecord::Base
  #Submit to the ENCODE Portal as a genetic_modification:
  # https://www.encodeproject.org/profiles/genetic_modification.json
  include ModelConcerns
  #crisprs only belong to biosamples.
  ABBR = "CRISPR"
  DEFINITION = "A genetic modification carried out using CRISPR technology.  This object links together one or more CRISPR Construct objects (each containing an individual guide sequence), and a Donor Construct object (containing the donor sequence). A new CRISPR Modificition is created at the Biosample level.  Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :from_prototype, class_name: "CrisprModification"
  has_many   :prototype_instances, class_name: "CrisprModification", foreign_key: "from_prototype_id", dependent: :restrict_with_exception
  belongs_to :biosample
  belongs_to :donor_construct
  belongs_to :genomic_integration_site, class_name: "GenomeLocation"

  # Each pcr_validation should be submitted to the ENCODE profile
  # https://www.encodeproject.org/profiles/genetic_modification_characterization.json.
  # This should be done after creation of the corresponding genetic_modification so that the
  # genetic_modification_characterization.characterizes property points to it.
  has_many :pcr_validations, class_name: "Pcr", dependent: :nullify
  has_and_belongs_to_many :crispr_constructs
  validates :crispr_constructs, presence: true, unless: Proc.new { |cm| cm.parents.any? }
  validates :category, presence: true, inclusion: {in: Enums::CRISPR_MOD_CATEGORIES, message: "Must be an element from the list #{Enums::CRISPR_MOD_CATEGORIES}"}
  validates :purpose, presence: true, inclusion: {in: Enums::CRISPR_MOD_PURPOSE, message: "Must be an element from the list #{Enums::CRISPR_MOD_PURPOSE}"}
  validates :upstream_identifier, uniqueness: true, allow_blank: true
  validates :name, presence: true, uniqueness: true
  validates :biosample, presence: true
  validates :donor_construct, presence: true

  accepts_nested_attributes_for :genomic_integration_site, allow_destroy: true
  accepts_nested_attributes_for :crispr_constructs, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }

  validate :verify_target

  def self.policy_class
    ApplicationPolicy
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

  def clone(associated_biosample_id:, associated_user_id:)
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
    times_cloned = self._times_cloned + 1
    clone = self.dup
    attrs = clone.attributes
    #attrs["id"] is currently nil:
    attrs["from_prototype_id"] = self.id
    attrs["biosample_id"] = associated_biosample_id
    attrs["user_id"] = associated_user_id
    attrs["name"] = "#{self.name} clone #{times_cloned}"
    attrs = CrisprModification.filter_clone_attributes(attrs)
    new_record = CrisprModification.create!(attrs)
    self.update!({_times_cloned: times_cloned })
    return new_record
  end

  def self.filter_clone_attributes(attrs)                                                              
    #Remove attributes that shouldn't be explicitely set for a clone  
    attrs.delete("created_at")
    attrs.delete("updated_at")
    attrs.delete("_times_cloned")
    attrs.delete("upstream_identifier")
  end

  def parents
    parents = []
    parent = self.from_prototype
    return parents
  end

  def all_crispr_constructs
    ccs = self.crispr_constructs
    self.parents.each do |p|
      if p.crispr_constructs.any?
        ccs << p.crispr_constructs
      end
    end
    return ccs
  end

  protected

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
