class Antibody < ActiveRecord::Base
	CLONALITY_TYPES = ["monoclonal", "polyclonal"]
  belongs_to :organism
  belongs_to :antibody_purifications
  belongs_to :vendor
  belongs_to :isotype
  belongs_to :human_gene
	validates  :organism_id, :antibody_purifications_id, :vendor_id, :isotype_id, :human_gene_id, presence: true
	validates  :vendor_product_identifier, :lot_identifier, :clonality, presence: true
	validates  :clonality, inclusion: CLONALITY_TYPES
end
