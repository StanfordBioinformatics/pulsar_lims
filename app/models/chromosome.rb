class Chromosome < ActiveRecord::Base
	has_many :genome_locations
  belongs_to :user
  belongs_to :reference_genome

	validates :name, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end
end
