class SequencingLibraryPrepKit < ActiveRecord::Base
	has_and_belongs_to_many :documents
	has_many :barcodes
	has_many :libraries
	has_many :paired_barcodes
	has_many :pooled_libraries
	has_many :sequencing_library_prep_kits
  belongs_to :user
  belongs_to :vendor
	#has a unique constraint on the combined columns :vendor_id and :name.

	validates :name, presence: true
	validates :vendor_id, presence: true
	validates_uniqueness_of :vendor_product_identifier, scope: :vendor_id, allow_blank: true
	validates_uniqueness_of :name, scope: :vendor_id
	accepts_nested_attributes_for :documents, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end

	def self.paired_end_kits
		return SequencingLibraryPrepKit.where({:supports_paired_end => true})
	end
		
end
