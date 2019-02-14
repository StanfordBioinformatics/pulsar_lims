require 'elasticsearch/model'
class Atacseq < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  ABBR = "AS"
  DEFINITION = "An ATAC-sSeq experiment"
  default_scope {order("lower(name)")}
  belongs_to :user
  has_and_belongs_to_many :documents
  has_many :replicates, -> {experimental}, class_name: "Library", dependent: :nullify

  validates :name, presence: true, uniqueness: true 


  def self.policy_class
    ApplicationPolicy
  end
end
