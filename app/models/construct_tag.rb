require 'elasticsearch/model'
class ConstructTag < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CT"
  DEFINITION = "A specific gene or named piece of DNA that is part of a cloning vector or insert to a cloning vector, such as eGFP or an antibiotic resistance gene.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  has_and_belongs_to_many :crispr_constructs
  has_and_belongs_to_many :donor_constructs
  belongs_to :user

  validates :name, presence: true, uniqueness: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

end
