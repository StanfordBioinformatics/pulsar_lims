class Plate < ActiveRecord::Base
	ROW_LETTERS = ("A".."Z").to_a
	DIMENSIONS = ["2x2","8x12"]
	
	has_many :wells, dependent: :destroy
  belongs_to :user
  belongs_to :sequencing_library_prep_kit
  belongs_to :vendor

	validates :vendor, presence: true
	validates :name, presence: true, uniqueness: true	
	validates :dimensions, inclusion: DIMENSIONS, presence: true

	def self.policy_class
		ApplicationPolicy
	end

	def self.row_letter(row_num)
		return ROW_LETTERS[row_num - 1]
	end

	def nrow
		return self.dimensions.split("x")[0].to_i
	end

	def ncol
		return self.dimensions.split("x")[1].to_i
	end
end
