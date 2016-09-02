class Antibody < ActiveRecord::Base
	CLONALITY_TYPES = ["monoclonal", "polyclonal"]
  belongs_to :organism
  has_and_belongs_to_many :antibody_purifications
  belongs_to :vendor
  belongs_to :isotype
  belongs_to :human_gene
	has_many   :libraries
	validates  :name, length: { maximum: 20 }
	validates  :name, :organism_id, :antibody_purifications, :vendor_id, :isotype_id, :human_gene_id, presence: true
	validates  :vendor_product_identifier, :lot_identifier, :clonality, presence: true
	validates  :clonality, inclusion: CLONALITY_TYPES
end
