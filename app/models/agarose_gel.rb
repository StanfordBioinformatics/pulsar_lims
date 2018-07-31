require 'elasticsearch/model'

class AgaroseGel < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "AG"
  DEFINITION = "Represents an agarose gel used in electrophoresis."

  belongs_to :user
  has_many :gel_lanes, dependent: :destroy

  accepts_nested_attributes_for :gel_lanes, allow_destroy: true 

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end

  def display
    "#{GelLane::ABBR}-#{self.id}"
  end

end
