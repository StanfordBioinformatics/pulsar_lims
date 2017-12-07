class AntibodyPurification < ActiveRecord::Base
	DEFINITION = "A purification method used to isolate an Antibody, i.e. affinity, IMAC. An Antibody can have many purification methods applied."

	has_and_belongs_to_many :antibodies
	belongs_to :user
	validates :name, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
