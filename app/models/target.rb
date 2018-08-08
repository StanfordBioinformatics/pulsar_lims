require 'elasticsearch/model'

class Target < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "TRG"
  DEFINITION = "The gene that is the target of an antibody or genetic modication.  Model abbreviation: #{ABBR}"
  has_many :antibodies
  has_many :crispr_constructs
  has_many :donor_constructs
  belongs_to :user

  validates  :upstream_identifier, uniqueness: true, allow_blank: true
  validates :name, length: { minimum: 1, maximum: 40 }, uniqueness: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 
end
