class Plate < ActiveRecord::Base
	DIMENSIONS = ["8x12"]
	
	has_many :wells
  belongs_to :user
  belongs_to :sequencing_library_prep_kit
  belongs_to :vendor

	validates :vendor, presence: true
	validates :name, presence: true, uniqueness: true	
	validates :dimensions, inclusion: DIMENSIONS, presence: true

	def self.policy_class
		ApplicationPolicy
	end

	def nrows
		return self.dimensions.split("x")[0]
	end

	def ncols
		return self.dimensions.split("x")[1]
	end
end
