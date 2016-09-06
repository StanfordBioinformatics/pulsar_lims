class Document < ActiveRecord::Base
	has_and_belongs_to_many :biosamples
	has_and_belongs_to_many :libraries
	###
	##Columns:
	# name
	# description
	# content_type
	# data
	# document_type_id (fkey)
	###
  belongs_to :document_type

	validates :name, length: { maximum: 20 }, presence: true, uniqueness: true
	validates :description, :content_type, :data, presence: true

	def uploaded_document=(document_field)
		self.name = format_filename(document_field.original_filename)
		self.content_type = document_field.content_type.chomp
		self.data = document_field.read
	end

	def format_filename(filename)
		File.basename(filename).gsub(/[^\w._-]/,"")
	end
end
