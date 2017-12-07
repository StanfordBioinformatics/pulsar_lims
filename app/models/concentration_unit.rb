class ConcentrationUnit < ActiveRecord::Base
	DEFINITION = "The concentration of a substance in a mixture, i.e. DNA concentration in a library preparation."
  belongs_to :user
	validates :name, presence: true, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
		
end
