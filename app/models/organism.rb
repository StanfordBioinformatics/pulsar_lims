require 'elasticsearch/model'

class Organism < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "ORG"
  DEFINITION = "Scientific name for a species.  Model abbreviation: #{ABBR}"
  has_many :antibodies
  belongs_to :user

  validates :name, uniqueness: true, presence: true
  validates :ncbi_taxon, presence: true
  validates :scientific_name, uniqueness: true, presence: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 
end
