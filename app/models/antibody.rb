class Antibody < ActiveRecord::Base
	CLONALITY_TYPES = ["monoclonal", "polyclonal"]
  has_and_belongs_to_many :antibody_purifications
	belongs_to :user
  belongs_to :vendor
	belongs_to :organism
  belongs_to :isotype
  belongs_to :target

	validates  :name, length: { maximum: 40 }, presence: true, uniqueness: true
	#validates  :antibody_purifications, presence: true
	validates  :vendor_id, presence: true
	validates  :target_id, presence: true
	validates  :vendor_product_identifier, presence: true
	validates  :lot_identifier, presence: true
	validates  :clonality, inclusion: CLONALITY_TYPES, presence: true

	accepts_nested_attributes_for :antibody_purifications, allow_destroy: true

	def self.policy_class
		ApplicationPolicy
	end

	def add_antibody_purifications(purifications)
		"""
		Function : Adds AntibodyPurification associations to the self.antibody_purifications attr. 
		Args     : purification - Array of AntibodyPurification primary key IDs.
		"""
		if purifications.nil?
			return
		end
		purifications.each do |p| 
			if not p.empty?
				pur = AntibodyPurification.find(p)
				if not antibody_purifications.include? pur 
					antibody_purifications << pur 
				end
			end 
		end 
	end 

#	def remove_antibody_purifications(purifications)
#		"""
#		Function : Removes AntibodyPurification associations from the self.antibody_purifications attr. 
#		Args     : purifications - Array of AntibodyPurification foreign key IDs.
#		"""
#		if purifications.nil?
#			return
#		end
#		purifications.each do |p| 
#			pur = AntibodyPurification.find(p)
#			if antibody_purifications.include? pur 
#				antibody_purifications.destroy(pur)
#			end 
#		end 
#	end 

end
