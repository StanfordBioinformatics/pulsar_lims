class DocumentType < ActiveRecord::Base
	validates :name, presence: true
end
