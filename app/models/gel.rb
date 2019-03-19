require 'elasticsearch/model'

class Gel < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "GEL"
  DEFINITION = "Represents an agarose or polyacrylamide gel used in electrophoresis. Model abbreviation: #{ABBR}"

  belongs_to :immunoblot
  belongs_to :pcr
  belongs_to :user
  has_many :gel_lanes, dependent: :destroy
  has_many :biosamples, through: :gel_lanes
  has_many :gel_images, dependent: :destroy
  validates :voltage, numericality: {greater_than: 0}, allow_blank: true
  validate :validate_owner, on: [:create, :update]
  validate :validate_pcr_immunoblot # Both shouldn't be present

  accepts_nested_attributes_for :gel_lanes, allow_destroy: true 

  scope :persisted, lambda { where.not(id: nil) }
  scope :available, lambda { where(immunoblot_id: nil, pcr_id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def display
    "#{Gel::ABBR}-#{self.id}"
  end

private

  def validate_owner
    if self.pcr_id.present? and self.immunoblot_id.present?
        self.errors.add(:base, "can't be linked to both a PCR and an Immunoblot.")
    end
  end

  def validate_pcr_immunoblot
    if self.pcr.present? and self.immunoblot.present?
      self.errors[:base] << "cannot belong to both a Pcr and an Immunoblot."
    end
  end

end
