require 'elasticsearch/model'
class Shipping < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "SH"
  DEFINITION = "Tracks the shipping details of a biosample or package, such as from, to, carrior, tracking number, and when it was received."
  default_scope {order("date_shipped")}
  belongs_to :biosample
  belongs_to :user
  belongs_to :from, class_name: "Address"
  belongs_to :to, class_name: "Address"

  validates :from, presence: true
  validates :to, presence: true

  def self.policy_class
    ApplicationPolicy
  end
end
