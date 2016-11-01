class Vendor < ActiveRecord::Base
	has_many :biosample
	has_many :antibodies
	has_many :libraries
	belongs_to :user
	
	validates :name, :title, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
