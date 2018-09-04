require 'elasticsearch/model'

class LibraryFragmentationMethod < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "LFM"
  DEFINITION = "The method used to shear the DNA during Library preparation.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  has_many :libraries

  validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end
end
