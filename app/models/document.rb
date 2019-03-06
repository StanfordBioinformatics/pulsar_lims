require 'elasticsearch/model'

class Document < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "DOC"
  DEFINITION = "A general purpose document that may be referenced across different objects, and that is uploaded directly to the database. These are typically protocol documents, which are often reused. For a document that is more specific (i.e. one-time-use), it's better to upload it to a specific Data Storage location and then refernce this using a File Reference on the dependent object.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  #The is_protocol bool column has a default of false.
  has_many :analyses, foreign_key: :protocol_id, dependent: :nullify
  has_and_belongs_to_many :atacseqs
  has_and_belongs_to_many :biosamples
  has_and_belongs_to_many :chipseq_experiments
  has_and_belongs_to_many :crispr_modifications
  has_and_belongs_to_many :immunoblots
  has_and_belongs_to_many :treatments
  has_and_belongs_to_many :libraries
  has_and_belongs_to_many :sequencing_library_prep_kits
  has_and_belongs_to_many :single_cell_sortings
  belongs_to :user
  belongs_to :donor_construct
  belongs_to :crispr_construct
  ###
  ##Columns:
  # name
  # description
  # content_type
  # data
  # document_type_id (fkey)
  ###
  belongs_to :document_type

  validates  :upstream_identifier, uniqueness: true, allow_blank: true
  validates :name, length: { maximum: 100 }, presence: true, uniqueness: true
  validates :description, presence: true
  validates :content_type, presence: true
  validates :data, presence: true
  validates :document_type, presence: true
  validates :is_protocol, inclusion: { in: [true, false] }

  scope :persisted, lambda { where.not(id: nil) }
  scope :protocols, lambda { where(is_protocol: true) }

  # Overwrite Elasticsearch method
  def as_indexed_json(options={})
    as_json(except: [:data])
  end

  def self.policy_class
    ApplicationPolicy
  end 

  def uploaded_document=(document_field)
    self.name = format_filename(document_field.original_filename)
    self.content_type = document_field.content_type.chomp
    self.data = document_field.read
  end

  def format_filename(filename)
    File.basename(filename).gsub(/[^\w._-]/,"")
  end
end
