require 'elasticsearch/model'

class SequencingResult < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "SRES"
  DEFINITION = "Represents the sequencing results for a given Library.  Model abbreviation: #{ABBR}"
  attr_accessor :barcode_id
  #Does not have a :name attribute, which  most other models do. Instead, the display() methods is used to show a name where
  # needed.
  has_many :analyses, foreign_key: :input_reads_id, dependent: :nullify
  belongs_to :library
  belongs_to :user
  belongs_to :sequencing_run

  validates :library, presence: true, unless: lambda {|rec| rec.merged?}
  validates :read1_count, numericality: { greater_than: 0 }, allow_nil: true
  validates :read2_count, numericality: { greater_than: 0 }, allow_nil: true
  validates_uniqueness_of :library, scope: :sequencing_run, message: "sequencing result already exists for this library."


  scope :persisted, lambda { where.not(id: nil) }
  validate :validate_library #make sure library is present on sequencing_request.

  def self.policy_class
    ApplicationPolicy
  end

  def library_dual_indexed?
    library.dual_indexed?
  end

  def params_for_url_for
    #Returns the argument that can be used for the url_for helper (see use in the welcome controller).
    #See https://github.com/nathankw/pulsar_lims/wiki/search. 
    return [self.sequencing_run.sequencing_request,self.sequencing_run,self]
  end

  protected
    def validate_library
      #I think rails runs the custom validations first, so need to check below that the library was set.
      return unless self.library.present?
      if sequencing_run.sequencing_request.libraries.include?(self.library)
        return true
      end
      errors[:library] << "#{self.library.name} is not present on the sequencing request."
      return false
    end
end
