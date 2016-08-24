class Document < ActiveRecord::Base
	belongs_to :biosample
	###
	##Columns:
	# name
	# description
	# content_type
	# data
	# document_type_id (fkey)
	###
  belongs_to :document_type
	validates :name, :description, :content_type, :data, presence: true

	def uploaded_document=(document_field)
		self.name = File.basename(document_field.original_filename)
		self.content_type = document_field.content_type.chomp
		self.data = document_field.read
	end
end
