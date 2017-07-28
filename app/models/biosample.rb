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
	has_one :crispr, validate: true
	has_one :starting_biosample_single_cell_sorting, class_name: "SingleCellSorting", foreign_key: :starting_biosample_id #the starting biosample used for sorting. Not required.
	has_one :sorting_biosample_single_cell_sorting, class_name: "SingleCellSorting", foreign_key: :sorting_biosample_id #the starting biosample used for sorting. Not required.
	belongs_to  :user
	belongs_to  :biosample_term_name
	belongs_to  :biosample_type
	belongs_to  :donor
  belongs_to  :vendor
	has_many    :libraries, dependent: :destroy
	
	#validates :name, uniqueness: true, length: { minimum: 2, maximum: 40 }, presence: true
	validates :name, uniqueness: true
	#validates :documents, presence: true
	validates :biosample_type_id, presence: true
	validates :biosample_term_name_id, presence: true
	validates :vendor_id, presence: true
	validates :donor_id, presence: true

	accepts_nested_attributes_for :documents, allow_destroy: true

	scope :non_well_biosamples, lambda { where(well: nil, prototype: false) }
	scope :non_prototypes, lambda { where(prototype: false) }
	scope :persisted, lambda { where.not(id: nil) }

	after_update :propagate_update_if_prototype
	#after_validation :propagate_update_if_prototype, on: :update
	before_save :set_name

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

	#private #comment-out for testing in the console.

		def propagate_update_if_prototype
			#An after_update callback.
			#If this is a prototype biosample, then we need to propagate the update to dependent biosamples.
			# In the case of single_cell_sorting, dependent biosamples are those sorted into the wells of each plate on the experiment
			# (each well has a single biosample and such a biosample has a single library).
			# This makes updating all of the biosample objects with regard to all the plates on a single_cell_sorting 
			# easy to do just by changing the biosample prototype (starting biosample) assocated with the single_cell_sorting.
			if sorting_biosample_single_cell_sorting.present? 
				sorting_biosample_single_cell_sorting.plates.each do |plate|
					plate.wells.each do |well|
						well.update_biosample_from_prototype
#						if well.biosample.errors.any?
#							well.biosample.errors.full_messages.each do |msg|
#								errors["Wellll #{well.name} -> "] << msg
#							end
#							return false #doens't matter whether I say false here
#						end
					end
				end
			end
		end

	private

	def set_name
		if self.well.present?
			#A well biosample has it's own naming format
			self.name = self.well.plate.single_cell_sorting.name + " " + self.well.plate.name + " " +  self.well.get_name #(sorting exp name) + (plate name) + (well name)
		end
	end
end
