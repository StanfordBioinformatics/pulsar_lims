require 'elasticsearch/model'
class Unit < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "UN"
  DEFINITION = "Stores units of concentration, mass, and volume. Model abbreviation: #{ABBR}"
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :unit_type, presence: true, inclusion: {in: Enums::UNIT_TYPES, message: "must be an element from the list #{Enums::UNIT_TYPES}"}

  def self.policy_class
    ApplicationPolicy
  end

  def to_label
    # Shadows the to_label method defined in /app/models/concerns/model_concerns.
    self.name
  end
    
end
