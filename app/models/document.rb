class Document < ActiveRecord::Base
	#The is_protocol bool column has a default of false.
	has_and_belongs_to_many :biosamples
	has_and_belongs_to_many :libraries
	belongs_to :user
	###
	##Columns:
	# name
	# description
	# content_type
	# data
	# document_type_id (fkey)
	###
  belongs_to :document_type

	validates :name, length: { maximum: 40 }, presence: true, uniqueness: true
	validates :description, presence: true
	validates :content_type, presence: true
	validates :data, presence: true
	validates :is_protocol, inclusion: { in: [true, false] }

	scope :persisted, lambda { where.not(id: nil) }
	scope :protocols, lambda { where(is_protocol: true) }

	def self.policy_class
		ApplicationPolicy
	end 

	def uploaded_document=(document_field)
		self.name = format_filename(document_field.original_filename)
		self.content_type = document_field.content_type.chomp
		self.data = document_field.read
		#Rails.logger.debug(self.data.to_s)
	end

	def format_filename(filename)
		File.basename(filename).gsub(/[^\w._-]/,"")
	end
end
