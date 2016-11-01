class AntibodyPurification < ActiveRecord::Base
	has_and_belongs_to_many :antibodies
	belongs_to :user
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
