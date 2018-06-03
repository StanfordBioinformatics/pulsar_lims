require 'elasticsearch/model'
class BiosampleTermName < ActiveRecord::Base
  include Elasticsearch::Model                                                                         
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "BTN"
  DEFINITION = "A term name and accession that describes what a particular biosample is, i.e. anatomical provenance (tissue) or cell type, and which belongs to a particular Biosample Ontology.  Model abbreviation: #{ABBR}"
  #The ENCODE DCC uses three ontologies for Biosamples:
  #
  # 1) Cell Ontology (CL),
  # 2) Experimental Factor Ontology (EFO), and
  # 3) Uberon
  #
  # See https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4360730/ for a description of how ENCODE uses
  # these ontologies. In summary, ENCODE categorizes biosamples into seven types, each of which
  # uses accessions from one of the CL, EFO, or Uberon ontologies, depending on the biosample type.
  # This categorization and assigment of ontologies is as follow:
  # 
  #   BIOSAMPLE_TYPE (ONTOLOGY)
  #  1) tissue (Uberon),
  # 2) whole organism (Uberon),
  # 3) primary cell (CL),
  # 4) stem cell (CL),
  # 5) cell line (EFO),
  # 6) in vitro differentiated cell (CL or EFO),
  # 7) induced pluripotent stem cell (EFO)
  #
  #Note that the ENCODE DCC requires that all ontology accessions start with the ontology prefix separated by
  # a ':" followed by the identifier. This is the case for Uberon and CL accessions, but EFO accessions are
  # instead separated by a '_". This table stores the accessions as they are naturally stored in the corresponding
  # ontologies. Thus for EFO accessions, the API will need to replace the '_' with a ':' prior to submission to DCC.
  belongs_to :user
  belongs_to :biosample_ontology
  has_many   :biosamples

  validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true, presence: true
  validates :accession, presence: true, format: { with: /\A(CL:|UBERON:|EFO:)[0-9]{2,8}\z/, message: "Must begin with CL:, UBERON:, or EFO:, followed by two to eight numbers." }
  validates :biosample_ontology_id, presence: true

  scope :cl, lambda { where(biosample_ontology_id: BiosampleOntology.find_by(name: "CL")) }
  scope :uberon, lambda { where(biosample_ontology_id: BiosampleOntology.find_by(name: "Uberon")) }
  scope :efo, lambda { where(biosample_ontology_id: BiosampleOntology.find_by(name: "EFO")) }
  scope :persisted, lambda { where.not(id: nil) }


  def self.policy_class
    ApplicationPolicy
  end
end
