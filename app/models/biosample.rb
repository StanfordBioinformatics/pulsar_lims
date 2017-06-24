class Biosample < ActiveRecord::Base
	###
	#Add self reference so that a part_of biosample can be modelled:
	has_one :well, dependent: :destroy
	has_many :child_biosamples, class_name: "Biosample", foreign_key: "parent_biosample_id", dependent: :destroy
	belongs_to :parent_biosample, class_name: "Biosample"
	###
	has_and_belongs_to_many :documents
	has_one :crispr
	has_one :plate, foreign_key: :starting_biosample_id, dependent: :destroy #the starting biosample used for sorting. Not required.
	belongs_to  :user
	belongs_to  :biosample_term_name
	belongs_to  :biosample_type
	belongs_to  :donor
  belongs_to  :vendor
	has_many    :libraries
	
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :documents, presence: true
	validates :biosample_type_id, presence: true
	validates :biosample_term_name_id, presence: true
	validates :vendor_id, presence: true
	validates :donor_id, presence: true

	accepts_nested_attributes_for :documents, allow_destroy: true

	def self.policy_class
		ApplicationPolicy
	end 

	def self.possible_biosample_terms(biosample_type)
		BiosampleTermName.all
	end

end
