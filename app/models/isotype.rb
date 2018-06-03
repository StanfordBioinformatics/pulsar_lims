require 'elasticsearch/model'
class Isotype < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "ITY"
  DEFINITION = "An antibody isotype or subtype, i.e. IgG, IgG1, ... Model abbreviation: #{ABBR}"
  has_many :antibodies
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 
end
