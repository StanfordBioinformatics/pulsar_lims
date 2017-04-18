class Plate < ActiveRecord::Base
  belongs_to :user
  belongs_to :sequencing_library_prep_kit
  belongs_to :vendor

	validates :vendor, presence: true
	validates :name, presence: true, uniqueness: true	
	validates :num_rows, presence: true
	validates :num_cols, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
