require 'enums'
class Treatment < ActiveRecord::Base
  include ModelConcerns
  ABBR = "TRT"
  DEFINITION = "A treatment applied to a biosample.  Model abbreviation: #{ABBR}"
  belongs_to :user
  belongs_to :treatment_term_name
  belongs_to :concentration_unit
  has_and_belongs_to_many :biosamples
  has_and_belongs_to_many :documents

  validates  :upstream_identifier, uniqueness: true, allow_blank: true
  validates :concentration_unit, presence: {message: "must be specified when 'concentration' is set."}, if: "concentration.present?"
  validates :duration_units, presence: {message: "must be specified when 'duration' is set."}, if: "duration.present?"
  validates :name, uniqueness: true, length: { minimum: 2, maximum: 40 }, allow_blank: true
  validates :treatment_term_name_id, presence: true
  validates :treatment_type, presence: true, inclusion: {in: Enums::TREATMENT_TYPES, message: "Must be an element from the list #{Enums::TREATMENT_TYPES}"}
  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class 
    ApplicationPolicy
  end
end

