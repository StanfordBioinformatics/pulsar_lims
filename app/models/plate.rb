class Plate < ActiveRecord::Base
  attr_accessor :add_barcodes #used only in the show view in the form at the bottom.
	ROW_LETTERS = ("A".."Z").to_a
	DIMENSIONS = ["2x2 (4)","8x12 (96)","16x24 (384)"]
	
	has_many :wells, dependent: :destroy
	belongs_to :pooled_library
  belongs_to :user
	belongs_to :single_cell_sorting, required: true
  belongs_to :vendor

	validates :dimensions, inclusion: DIMENSIONS, presence: true
	validates :name, presence: true
	validates_uniqueness_of :name, scope: :single_cell_sorting, message: "Another plate in this experiment already exists with this name."
	validates :vendor, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	after_validation :add_wells, on: :create

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
		sorting_biosample = single_cell_sorting.sorting_biosample
		sub_biosample = sorting_biosample.dup
		sub_biosample.documents = sorting_biosample.documents
		rows = self.nrow
		cols = self.ncol
		(1..rows).each do |r| 
			(1..cols).each do |c| 
				#name format is ${parent_biosample_name}_${plate_name}_${row_num}-${col_num}
				well = wells.build({user: self.user, row: r, col: c}) 
				if not well.valid?
					well.errors.full_messages.each do |well_err|
						errors["-> Well:"] << well_err
					end
					return
				end

				sub_biosample.name = sorting_biosample.name + " " + name + " " +  well.get_name
				b = well.build_biosample(sub_biosample.attributes)
				if not b.valid?
					b.errors.full_messages.each do |e|
						errors["well -> biosample:"] <<  e
					end
					return
				else
				end
			end 
		end 
	end 
end
