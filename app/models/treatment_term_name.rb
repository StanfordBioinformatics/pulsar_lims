require 'elasticsearch/model'

class TreatmentTermName < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "TTN"
  DEFINITION = "Models the agent used in a biosample treatment. This is linked to the Treatment model.  Model abbreviation: #{ABBR}"
  belongs_to :user
  has_many :biosamples

  validates :accession, presence: true,  format: { with: /\A(CHEBI:[0-9]{1,7})|(UniProtKB:[A-Z0-9]{6})|(Taxon:[0-9]{2,7})|(NTR:[0-9]{2,8})|(CL:[0-9]{2,8})|(XCO:[0-9]{7})\z/, message: "Must begin with CHEBI:, UniProtKB:, Taxon:, or CL:, followed by a number."}
  validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true, presence: true

  def self.policy_class
    ApplicationPolicy
  end
end
