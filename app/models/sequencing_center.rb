class SequencingCenter < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true, length: { minimum: 2, maximum: 20 }
	validates :address, uniqueness: true, presence: true
	
	def self.policy_class
		ApplicationPolicy
	end
end
