class SequencingCenter < ActiveRecord::Base
	belongs_to :user
	validates :name, uniqueness: true, presence: true, length: { minimum: 2, maximum: 30 }
	validates :address, uniqueness: true, presence: true
	
	def self.policy_class
		ApplicationPolicy
	end
end
