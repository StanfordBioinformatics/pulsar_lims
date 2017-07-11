class Biosample < ActiveRecord::Base
	###
	#Add self reference so that a part_of biosample can be modelled:
	#Has a 'prototype' boolean column that defaults to false. When true, means that it's a virtual biosample.
	# Virtual biosamples are used currently in the single_cell_sorting model via the sorting_biosample_id foreign key.
	# This biosample is a prototype used as a reference for creating the biosamples in the wells of the plates on
	# the single_cell_sorting experiment. 
	belongs_to :well  
	has_many :child_biosamples, class_name: "Biosample", foreign_key: "parent_biosample_id", dependent: :destroy
	belongs_to :parent_biosample, class_name: "Biosample"
	###
	has_and_belongs_to_many :documents
	has_one :crispr
	has_one :starting_biosample_single_cell_sorting, class_name: "SingleCellSorting", foreign_key: :starting_biosample_id #the starting biosample used for sorting. Not required.
	has_one :sorting_biosample_single_cell_sorting, class_name: "SingleCellSorting", foreign_key: :sorting_biosample_id #the starting biosample used for sorting. Not required.
	belongs_to  :user
	belongs_to  :biosample_term_name
	belongs_to  :biosample_type
	belongs_to  :donor
  belongs_to  :vendor
	has_many    :libraries
	
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	#validates :documents, presence: true
	validates :biosample_type_id, presence: true
	validates :biosample_term_name_id, presence: true
	validates :vendor_id, presence: true
	validates :donor_id, presence: true

	accepts_nested_attributes_for :documents, allow_destroy: true

	scope :non_well_biosamples, lambda { where(well: nil, prototype: false) }
	scope :non_prototypes, lambda { where(prototype: false) }

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 

	def self.possible_biosample_terms(biosample_type)
		BiosampleTermName.all
	end

	def document_ids=(ids)
		""" 
		Function : Adds associations to Documents that are stored in self.documents.
		Args     : ids - array of Document IDs.
		"""
		ids.each do |i|
			if i.blank?
				next
			end
			doc = Document.find(i)
			if not self.documents.include? doc
				self.documents << doc
			end 
		end
	end
end
