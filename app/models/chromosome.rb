require 'elasticsearch/model'
class Chromosome < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CHR"
  DEFINITION = "A chromosome identifier of a particular reference genome build.  Model abbreviation: #{ABBR}"
  has_many :genome_locations
  belongs_to :user
  belongs_to :reference_genome

  validates :reference_genome_id, presence: true
  validates_uniqueness_of :name, scope: :reference_genome_id
  validates :name, presence: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def display
    "#{@chromosome.name} on #{@reference_genome.name}"
  end

  def params_for_url_for
    #Returns the argument that can be used for the url_for helper (see use in the welcome controller).
    #See https://github.com/nathankw/pulsar_lims/wiki/search.
    return [self.reference_genome, self]
  end
end
