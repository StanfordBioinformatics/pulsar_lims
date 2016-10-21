class AntibodyPurification < ActiveRecord::Base
	has_and_belongs_to_many :antibodies
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
