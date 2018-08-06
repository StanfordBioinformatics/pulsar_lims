require 'elasticsearch/model'
class Immunoblot < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "IB"
  DEFINITION = "Immunoblot"

  belongs_to :analyst, class_name: "User"
  belongs_to :primary_antibody, class_name: "Antibody"
  belongs_to :primary_antibody_concentration_units, class_name: "Unit"
  belongs_to :secondary_antibody, class_name: "Antibody"
  belongs_to :secondary_antibody_concentration_units, class_name: "Unit"
  belongs_to :user
  has_one :agarose_gel
  has_and_belongs_to_many :documents

  validates :primary_antibody_concentration_units, presence: {message: "must be specified when 'primary antibody concentration' is specified."}, if: "primary_antibody_concentration.present?"
  validates :secondary_antibody_concentration_units, presence: {message: "must be specified when 'secondary antibody concentration' is specified."}, if: "secondary_antibody_concentration.present?"
  validate :validate_concentration_units

  accepts_nested_attributes_for :documents, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def display
    self.get_record_id()
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

  private

  def validate_concentration_units
    if self.primary_antibody_concentration_units.present?
      if self.primary_antibody_concentration_units.unit_type != "concentration"
        self.errors.add(:primary_antibody_concentration_units_id, "must be a concentration type of unit.")
        return false
      end
    end
    if self.secondary_antibody_concentration_units.present?
      if self.secondary_antibody_concentration_units.unit_type != "concentration"
        self.errors.add(:secondary_antibody_concentration_units_id, "must be a concentration type of unit.")
        return false
      end
    end
  end
end
