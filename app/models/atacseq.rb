require 'elasticsearch/model'
class Atacseq < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "AS"
  DEFINITION = "An ATAC-sSeq experiment"
  default_scope {order("lower(name)")}
  belongs_to :user
  has_and_belongs_to_many :documents
  has_many :replicates, class_name: "Library", dependent: :nullify

  validates :name, presence: true, uniqueness: true

  scope :multiome, lambda { where(multiome: true) }
  scope :snrna, lambda { where(snrna: true) }
  scope :single_cell, lambda { where(single_cell: true) }
  scope :bulk, lambda { where(single_cell: false) }

  accepts_nested_attributes_for :documents, allow_destroy: true

  def self.policy_class
    ApplicationPolicy
  end

  def replicate_ids=(ids)
    """
    Function : Adds associations to Libraries that are stored in self.replicates.
    Args     : ids - array of Library IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      rec = Library.find(i)
      if not self.replicates.include? rec
        self.replicates << rec
      end
    end
  end
  
  def document_ids=(ids)
    """
    Function : Adds associations to Documents that are stored in self.documents.
    Args     : ids - array of Document IDs.
    """
    ids.each do |i|
      if i.blank?
        next
      end
      doc = Document.find(i)
      if not self.documents.include? doc
        self.documents << doc
      end
    end
  end
end
