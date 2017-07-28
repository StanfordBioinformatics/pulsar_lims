class Plate < ActiveRecord::Base
  attr_accessor :add_barcodes #used only in the show view in the form at the bottom.
	ROW_LETTERS = ("A".."Z").to_a
	DIMENSIONS = ["2x2 (4)","8x12 (96)","16x24 (384)"]
	
	has_many :wells, dependent: :destroy  #"validate: true" is default for has_many
	has_and_belongs_to_many :sequencing_requests
	belongs_to :single_cell_sorting, required: true 
  belongs_to :user
  belongs_to :vendor

	validates :dimensions, inclusion: DIMENSIONS, presence: true
	validates :name, presence: true
	validates_uniqueness_of :name, scope: :single_cell_sorting, message: "Another plate in this experiment already exists with this name."
	validates :vendor, presence: true

	scope :persisted, lambda { where.not(id: nil) }

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

	def get_barcodes
		barcodes = []
			wells.each do |w|
			if w.biosample.present? and w.biosample.libraries.present?
				lib = w.biosample.libraries.last
				if lib.paired_end?
					barcode = lib.paired_barcode
				else
					barcode = lib.barcode 
				end
				barcodes << barcode #barcode could be nil if no barcoding is used.
			end
		end
		return barcodes
	end

	private

  def add_wells
		if not self.valid?
			return false
			#otherwise, the callbacks will continue on. The whole transaction would still fail
		end
		rows = self.nrow
		cols = self.ncol
		(1..rows).each do |r| 
			(1..cols).each do |c| 
				#name format is ${parent_biosample_name}_${plate_name}_${row_num}-${col_num}
				well = wells.create({user: self.user, row: r, col: c}) 
				if not well.valid?
					raise "Unable to create well #{well.name}: #{well.errors.full_messages}"
					#caught in single_cell_sortings_controller.rb, where it sets a :alert in the flash.
				end
			end 
		end 
	end 
end
