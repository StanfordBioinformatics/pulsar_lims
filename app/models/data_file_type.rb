require 'elasticsearch/model'
class DataFileType < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "DFTY"
  DEFINITION = "Indicates the type of a file containing raw data or analysis results, i.e. FASTQ, BAM, BED, VCF, TSV.  The File Reference model references this one.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  has_many :file_references

  validates :name, presence: true, uniqueness: true

  def self.policy_class
    ApplicationPolicy
  end 

end
