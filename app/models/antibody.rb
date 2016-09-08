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



	def add_antibody_purifications(ab_pur_ids)
		"""
		Function : Adds AntibodyPurification associations to the self.antibody_purifications attr. 
		Args     : ab_pur_ids - Array of AntibodyPurification foreign key IDs.
		"""
		if ab_pur_ids.blank?
			return
		end
		ab_pur_ids.each do |p| 
			if not p.empty?
				pur = AntibodyPurification.find(p)
				if not antibody_purifications.include? pur 
					antibody_purifications << pur 
				end
			end 
		end 
	end 

	def remove_antibody_purifications(ab_pur_ids)
		"""
		Function : Removes AntibodyPurification associations from the self.antibody_purifications attr. 
		Args     : ab_pur_ids - Array of AntibodyPurification foreign key IDs.
		"""
		if ab_pur_ids.blank?
			return
		end 
		ab_pur_ids.each do |p| 
			pur = AntibodyPurification.find(p)
			if antibody_purifications.include? pur 
				antibody_purifications.destroy(pur)
			end 
		end 
	end 

end
