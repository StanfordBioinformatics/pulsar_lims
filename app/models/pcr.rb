require 'elasticsearch/model'

class Pcr < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ModelConcerns
  ABBR = "PCR"
  DEFINITION = "A PCR assay.  Model abbreviation: #{ABBR}"
  default_scope {order("lower(name)")}
  belongs_to :user
  belongs_to :analyst, class_name: "User"
  belongs_to :biosample
  belongs_to :document
  belongs_to :forward_primer, class_name: "Primer"
  belongs_to :reverse_primer, class_name: "Primer"
  belongs_to :genomic_dna_concentration_units, class_name: "Unit"
  belongs_to :pcr_master_mix
  belongs_to :gel

  validates :biosample, presence: true
  validates :forward_primer, presence: true
  validates :reverse_primer, presence: true
  validates :name, uniqueness: true, allow_blank: true
  validates :pcr_master_mix, presence: true

  validates :forward_primer, with: :validate_forward_primer                                            
  validates :reverse_primer, with: :validate_reverse_primer  

  def self.policy_class
    ApplicationPolicy
  end

  private
 
  def validate_forward_primer
    if self.forward_primer.direction != Primer::FORWARD_D
      self.errors[:forward_primer] << "must be a forward primer."
    end
  end

  def validate_reverse_primer
    if self.reverse_primer.direction != Primer::REVERSE_D
      self.errors[:reverse_primer] << "must be a reverse primer."
    end
  end
end
