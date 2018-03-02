require 'enums'
class Treatment < ActiveRecord::Base
  ABBR = "TRT"
  DEFINITION = "A treatment applied to a biosample."
  belongs_to :user
  belongs_to :treatment_term_name
  belongs_to :concentration_unit
  has_and_belongs_to_many :biosamples

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 40 }
  validates :treatment_term_name_id, presence: true
  validates :treatment_type, presence: true, inclusion: {in: Enums::TREATMENT_TYPES, message: "Must be an element from the list #{Enums::TREATMENT_TYPES}"}

  def self.policy_class 
    ApplicationPolicy
  end
end

