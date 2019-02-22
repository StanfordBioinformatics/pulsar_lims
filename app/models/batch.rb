require 'elasticsearch/model'
class Batch < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "CB"
  DEFINITION = "Howdy"
  #default_scope {order("lower(name)")} #no name column
  belongs_to :user
  belongs_to :analyst, class_name: "User"
  belongs_to :library_prototype, class_name: "Library", dependent: :destroy 
  has_many :batch_items, dependent: :destroy
  has_many :biosamples, through: :batch_items

  validates :analyst, presence: true
  validates :batch_type, inclusion: {in: Enums::BATCH_TYPES, message: "must be an element in the list #{Enums::BATCH_TYPES}"}
  validates :crosslinking_method, inclusion: {in: Enums::CROSSLINKING_METHOD, message: "must be an element in the list #{Enums::CROSSLINKING_METHOD}."}, allow_blank: true

  accepts_nested_attributes_for :batch_items, allow_destroy: true

  def self.policy_class
    ApplicationPolicy
  end
end
