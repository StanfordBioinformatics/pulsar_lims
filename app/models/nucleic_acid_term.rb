require 'elasticsearch/model'

class NucleicAcidTerm < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "NAT"
  DEFINITION = "The type of nucleic acid, i.e. DNA, RNA, polyadenylated mRNA.  Model abbreviation: #{ABBR}"
  has_many :libraries
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :accession, presence: true, uniqueness: true
  validates :definition, presence: true

  scope :persisted, lambda { where.not(id: nil) }

  def self.policy_class
    ApplicationPolicy
  end 
end
