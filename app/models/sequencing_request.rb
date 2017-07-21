class SequencingRequest < ActiveRecord::Base
	has_and_belongs_to_many :libraries
	has_and_belongs_to_many :plates
  belongs_to :sequencing_platform
  belongs_to :sequencing_center
	has_many    :sequencing_runs, dependent: :destroy
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true
	validates :sequencing_center, presence: true
	validates :sequencing_platform, presence: true

	accepts_nested_attributes_for :libraries, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	def get_library_with_barcode(barcode_id)
		if paired_end
			lib = libraries.find_by(paired_barcode_id: barcode_id)
		else
			lib = libraries.find_by(barcode_id: barcode_id)
		end
		return lib
	end

	def self.policy_class
		ApplicationPolicy
	end

end
