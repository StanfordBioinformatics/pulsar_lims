require 'elasticsearch/model'
class ChipBatchItem < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CBI"
  DEFINITION = "Represents one of the Biosamples processed in this ChipBatch."
  #default_scope {order("lower(name)")} #no name column
  belongs_to :antibody
  belongs_to :user
  belongs_to :biosample
  belongs_to :chip_batch
  belongs_to :concentration_unit, class_name: "Unit"
  belongs_to :library, dependent: :destroy

  validates :chip_batch_id, presence: true
  validates :biosample_id, presence: true
  validates :concentration, numericality: {greater_than: 0}, allow_blank: true
  validates :concentration_unit, presence: {message: "must be specified when the quantity is specified."}, if: "concentration.present?"
  validate :validate_concentration_units
  validate :validate_library

  accepts_nested_attributes_for :library, allow_destroy: true

  def self.policy_class
    ApplicationPolicy
  end

  private

  def validate_library
    if self.library.present?
      if not self.biosample.library_ids.include?(self.library_id)
        self.errors.add(:library_id, "selected must also be linked to the the given Biosample.")
      end
    end
  end

  def validate_concentration_units
    if self.concentration_unit.present?
      if self.concentration.blank?
        self.concentration_unit = nil
        return
      end
      if self.concentration_unit.unit_type != "concentration"
        self.errors.add(:concentration_unit_id, "must be a concentration type of unit.")
        return false
      end
    end
  end

end
