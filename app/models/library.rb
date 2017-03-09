class Library < ActiveRecord::Base
	NUCLEIC_ACID_STARTING_QUANTITY_UNITS = ["cells","cell-equivalent","µg","ng","pg","mg"]

	#The is_control bool column has a default of false.
	has_and_belongs_to_many :documents
	has_and_belongs_to_many :sequencing_requests
	has_and_belongs_to_many :barcodes
	has_many   :barcode_sequencing_results, dependent: :destroy
	belongs_to :antibody
	belongs_to :biosample
	belongs_to :library_fragmentation_method
	belongs_to :nucleic_acid_term
	belongs_to :user
	belongs_to :vendor

	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
	validates :barcode, format: { with: /\A[acgtnACGTN]+-?[acgtnACGTN]+\z/ }, allow_blank: true
	validates  :size_range, format: {with: /\A\d+-\d+\Z/}, presence: true
	validates :nucleic_acid_term_id, presence: true
	validates :documents, presence: true
	#validates :vendor_id, presence: true
	validates :biosample_id, presence: true
	#The fkey antibody_id doesn't need to be required since some libraries, such as ATAC-SEq, don't have an antibody.
	validates :nucleic_acid_starting_quantity_units, inclusion: NUCLEIC_ACID_STARTING_QUANTITY_UNITS, allow_blank: true #note that nil for string will be stored in the database as "".
	validates :nucleic_acid_starting_quantity_units, presence: true, if: "nucleic_acid_starting_quantity.present?"

	accepts_nested_attributes_for :documents, allow_destroy: true
	accepts_nested_attributes_for :sequencing_requests, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
