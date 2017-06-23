class Biosample < ActiveRecord::Base
	has_and_belongs_to_many :documents
	has_one :crispr
	belongs_to  :user
	belongs_to  :biosample_term_name
	belongs_to  :biosample_type
	belongs_to  :donor
  belongs_to  :vendor
	belongs_to  :well #i.e. in single cell experiments. Each sorted cell is a biosample in a well. Not required.
	belongs_to  :plate #the starting biosample used for sorting. Not required.
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
