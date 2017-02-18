class Target < ActiveRecord::Base
	has_many :antibodies
	belongs_to :user
	validates :encode_identifier, uniqueness: true, presence: true
	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

	def self.policy_class
		ApplicationPolicy
	end 
end
