require 'elasticsearch/model'
class Batch < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "BCH"
  DEFINITION = "Howdy"
  BULK_ATACSEQ = "bulk ATAC-seq"
  SC_ATACSEQ = "scATAC-seq"
  SN_RNASEQ = "snRNA-seq"
  CHIPSEQ = "ChIP-seq"
  # Note: If adding a new entry to BATCH_TYPES, then be sure to update the controller's new method. 
  BATCH_TYPES = [BULK_ATACSEQ, SC_ATACSEQ, SN_RNASEQ, CHIPSEQ]
  #default_scope {order("lower(name)")} #no name column
  belongs_to :user
  belongs_to :analyst, class_name: "User"
  belongs_to :library_prototype, class_name: "Library"
  has_many :batch_items, dependent: :destroy
  has_many :biosamples, through: :batch_items

  validates :analyst, presence: true
  validates :batch_type, inclusion: {in: Batch::BATCH_TYPES, message: "must be an element in the list #{Batch::BATCH_TYPES}"}
  validates :crosslinking_method, inclusion: {in: Enums::CROSSLINKING_METHOD, message: "must be an element in the list #{Enums::CROSSLINKING_METHOD}."}, allow_blank: true

  scope :sn_rnaseq, lambda { where(batch_type: Batch::SN_RNASEQ ) }
  scope :sc_atacseq, lambda { where(batch_type: Batch::SC_ATACSEQ ) }
  scope :bulk_atacseq, lambda { where(batch_type: Batch::BULK_ATACSEQ) }
  scope :chipseq, lambda { where(batch_type: Batch::CHIPSEQ) }
  accepts_nested_attributes_for :batch_items, allow_destroy: true

  def self.policy_class
    ApplicationPolicy
  end
end
