class Plate < ActiveRecord::Base
  attr_accessor :add_barcodes #used only in the show view in the form at the bottom.
	ROW_LETTERS = ("A".."Z").to_a
	DIMENSIONS = ["2x2 (4)","8x12 (96)","16x24 (384)"]
	
	has_many :wells, dependent: :destroy
	belongs_to :pooled_library
  belongs_to :user
  belongs_to :sequencing_library_prep_kit
	belongs_to :single_cell_sorting
  belongs_to :vendor

	validates :dimensions, inclusion: DIMENSIONS, presence: true
	validates :name, presence: true, uniqueness: true	
	validates :vendor, presence: true

	after_create :add_wells

	def self.policy_class
		ApplicationPolicy
	end

	def self.row_letter(row_num)
		return ROW_LETTERS[row_num - 1]
	end

	def nrow
		return self.dimensions.split()[0].split("x")[0].to_i
	end

	def ncol
		return self.dimensions.split()[0].split("x")[1].to_i
	end

	private

  def add_wells
		#should only be called after the plate has been persisted to the database.
		rows = self.nrow
		cols = self.ncol
		(1..rows).each do |r| 
			(1..cols).each do |c| 
				#name format is ${parent_biosample_name}_${plate_name}_${row_num}-${col_num}
				well = self.wells.create!({user: self.user, row: r, col: c}) 
			#	well.set_biosample
			end 
		end 
	end 
end
