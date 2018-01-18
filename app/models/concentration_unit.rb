class ConcentrationUnit < ActiveRecord::Base
	ABBR = "CU"
	DEFINITION = "The concentration of a substance in a mixture, i.e. DNA concentration in a library preparation. Model abbreviation: #{ABBR}"
  belongs_to :user
	validates :name, presence: true, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
		
end
