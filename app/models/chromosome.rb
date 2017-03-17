class Chromosome < ActiveRecord::Base
  belongs_to :user
  belongs_to :reference_genome

	validates :name, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
end
