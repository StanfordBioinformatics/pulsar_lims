class ConcentrationUnit < ActiveRecord::Base
  belongs_to :user
	validates :name, presence: true, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
		
end
