class Barcode < ActiveRecord::Base
	has_and_belongs_to_many :libraries

  belongs_to :user
  belongs_to :sequencing_library_prep_kit

	validates_uniqueness_of :name, scope: :sequencing_library_prep_kit_id
	validates :name, presence: true
	validates_uniqueness_of :sequence, scope: :sequencing_library_prep_kit_id
	validates :sequence, format: { with: /\A[acgtnACGTN]+\z/, message: "can only contain characters in the set ACTGN" }
	validates :sequencing_library_prep_kit, presence: true

	def self.policy_class
		ApplicationPolicy
	end

	def sequence=(sequence)
		write_attribute(:sequence,sequence.upcase())
	end

end
