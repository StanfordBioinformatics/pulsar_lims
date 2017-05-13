class Chromosome < ActiveRecord::Base
	has_many :genome_locations
  belongs_to :user
  belongs_to :reference_genome

	validates :reference_genome_id, presence: true
	validates_uniqueness_of :name, scope: :reference_genome_id
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
