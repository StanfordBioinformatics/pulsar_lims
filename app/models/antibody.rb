require 'elasticsearch/model'
class Antibody < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "AB"
  DEFINITION = "An antibody that was either purchased from a third party, or created from within the lab.  Model abbreviation: #{ABBR}"
  CLONALITY_TYPES = ["monoclonal", "polyclonal"]
  default_scope {order("lower(name)")}
  has_and_belongs_to_many :antibody_purifications
  has_and_belongs_to_many :plates
  belongs_to :user
  belongs_to :vendor
  belongs_to :organism
  belongs_to :isotype
  belongs_to :target
  belongs_to :concentration_units, class_name: "Unit"
  has_and_belongs_to_many :immunoblots

  validates  :upstream_identifier, uniqueness: true, allow_blank: true
  validates  :name, length: { maximum: 40 }, presence: true, uniqueness: true
  validates  :organism, presence: true
  #validates  :antibody_purifications, presence: true
  validates  :vendor_id, presence: true
  validates  :target_id, presence: true
  validates  :vendor_product_identifier, presence: true
  validates  :lot_identifier, presence: true
  validates  :clonality, inclusion: CLONALITY_TYPES, presence: true
  validates  :concentration, presence: {message: "must be specified when 'concentration units' is specified."}, if: "concentration_units.present?"
  validates  :concentration_units, presence: {message: "must be specified when 'concentration' is specified."}, if: "concentration.present?"
  validate :concentration_units, on: :save

  accepts_nested_attributes_for :antibody_purifications, allow_destroy: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def add_antibody_purifications(purifications)
    """
    Function : Adds AntibodyPurification associations to the self.antibody_purifications attr.
    Args     : purification - Array of AntibodyPurification primary key IDs.
    """
    if purifications.nil?
      return
    end
    purifications.each do |p|
      if not p.empty?
        pur = AntibodyPurification.find(p)
        if not antibody_purifications.include? pur
          antibody_purifications << pur
        end
      end
    end
  end

#  def remove_antibody_purifications(purifications)
#    """
#    Function : Removes AntibodyPurification associations from the self.antibody_purifications attr.
#    Args     : purifications - Array of AntibodyPurification foreign key IDs.
#    """
#    if purifications.nil?
#      return
#    end
#    purifications.each do |p|
#      pur = AntibodyPurification.find(p)
#      if antibody_purifications.include? pur
#        antibody_purifications.destroy(pur)
#      end
#    end
#  end

  private
    def validate_concentration_units
      if self.concentration_units.present?
        if self.concentration_units.unit_type != "concentration"
          self.errors.add(:concentration_units_id, "must be a concentration type of unit.")
          return false
        end
      end
    end

end
