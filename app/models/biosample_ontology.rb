require 'elasticsearch/model'

class BiosampleOntology < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "BO"
  DEFINITION = "An ontology providing biosample term names and accessions. The Biosample Term Name model links to this.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  has_many :biosample_term_names

  validates :name, presence: true
  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class                                                                                
    ApplicationPolicy                                                                                  
  end  

end
