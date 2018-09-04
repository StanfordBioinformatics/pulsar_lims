require 'elasticsearch/model'

require 'enums'
class Treatment < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "TRT"
  DEFINITION = "A treatment applied to a biosample.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  belongs_to :treatment_term_name
  belongs_to :concentration_unit, class_name: "Unit"
  has_and_belongs_to_many :biosamples
  has_and_belongs_to_many :documents

  validates  :upstream_identifier, uniqueness: true, allow_blank: true
  validates :concentration_unit, presence: {message: "must be specified when 'concentration' is set."}, if: "concentration.present?"
  validates :duration_units, presence: true, inclusion: {in: Enums::DURATION_UNITS, message: "must be specified when 'duration' is set, and must be an element from the list #{Enums::DURATION_UNITS}"}, if: "duration.present?"
  validates :name, uniqueness: true, presence: true, length: { minimum: 2, maximum: 40 }, allow_blank: true
  validates :treatment_term_name_id, presence: true
  validates :treatment_type, presence: true, inclusion: {in: Enums::TREATMENT_TYPES, message: "must be an element from the list #{Enums::TREATMENT_TYPES}"}
  validate :validate_concentration_unit
  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class 
    ApplicationPolicy
  end

  private

    def validate_concentration_unit                                                                    
      if self.concentration_unit.present?                                                              
        if self.concentration_unit.unit_type != "concentration"                                        
          self.errors.add(:concentration_unit_id, "must be a concentration type of unit.")             
          return false                                                                                 
        end                                                                                            
      end                                                                                              
    end   
end

