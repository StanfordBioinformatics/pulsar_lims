class DocumentType < ActiveRecord::Base
	has_many :documents
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
