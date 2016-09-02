class Antibody < ActiveRecord::Base
	CLONALITY_TYPES = ["monoclonal", "polyclonal"]
  belongs_to :organism
  has_and_belongs_to_many :antibody_purifications
  belongs_to :vendor
  belongs_to :isotype
  belongs_to :human_gene
	has_many   :libraries

	validates  :name, length: { maximum: 20 }, presence: true, uniqueness: true
	validates  :organism_id, presence: true
	validates  :antibody_purifications, presence: true
	validates  :vendor_id, presence: true
	validates  :isotype_id, presence: true
	validates  :human_gene_id, presence: true
	validates  :vendor_product_identifier, presence: true
	validates  :lot_identifier, presence: true
	validates  :clonality, inclusion: CLONALITY_TYPES, presence: true
end
