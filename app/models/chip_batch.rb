require 'elasticsearch/model'
class ChipBatch < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CB"
  DEFINITION = "Howdy"
  #default_scope {order("lower(name)")} #no name column
  belongs_to :user
  belongs_to :analyst, class_name: "User"
  has_many :chip_batch_items, dependent: :destroy
  has_many :biosamples, through: :chip_batch_items

  validates :analyst, presence: true
  validates :crosslinking_method, inclusion: {in: Enums::CROSSLINKING_METHOD, message: "must be an element in the list #{Enums::CROSSLINKING_METHOD}."}, allow_blank: true

  accepts_nested_attributes_for :chip_batch_items, allow_destroy: true

  def self.policy_class
    ApplicationPolicy
  end
end
