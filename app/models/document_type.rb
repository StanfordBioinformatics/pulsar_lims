class DocumentType < ActiveRecord::Base
	has_many :documents
	belongs_to :user
	validates :name, presence: true

	def self.policy_class
		ApplicationPolicy
	end 
end
