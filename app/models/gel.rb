require 'elasticsearch/model'

class Gel < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "GEL"
  DEFINITION = "Represents an agarose or polyacrylamide gel used in electrophoresis. Model abbreviation: #{ABBR}"

  belongs_to :immunoblot
  has_many :pcrs, dependent: :destroy
  belongs_to :user
  has_many :gel_lanes, dependent: :destroy
  has_many :biosamples, through: :gel_lanes
  has_many :gel_images, dependent: :destroy
  validates :voltage, numericality: {greater_than: 0}, allow_blank: true
  validate :validate_pcr_immunoblot # Both shouldn't be present

  accepts_nested_attributes_for :gel_lanes, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }
  scope :immunoblot_gels, lambda { where.not(immunoblot_id: nil) }
  scope :non_immunoblot_gels, lambda { where(immunoblot_id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def display
    "#{Gel::ABBR}-#{self.id}"
  end

  def pcr_ids=(ids)
    """
    Function : Adds associations to Pcrs that are stored in self.pcrs.
    Args     : ids - array of Pcr IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      doc = Pcr.find(i)
      if not self.pcrs.include? doc
        self.pcrs << doc
      end
    end
  end

private

  def validate_pcr_immunoblot
    if self.pcrs.any? and self.immunoblot.present?
      self.errors[:base] << "cannot belong to both a Pcr and an Immunoblot."
    end
  end

end
