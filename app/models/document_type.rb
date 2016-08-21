class DocumentType < ActiveRecord::Base
	has_many :documents
	validates :name, presence: true
end
