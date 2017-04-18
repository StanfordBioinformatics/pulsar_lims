class Well < ActiveRecord::Base
	ROW_LETTERS = ("A".."Z").to_a
  belongs_to :user
  belongs_to :plate
  belongs_to :barcode
  belongs_to :paired_barcode

	validates :row, presence: true
	validates :col, presence: true

	before_create :set_name


	protected	
		def set_name
			self.name = "#{ROW_LETTERS[self.row - 1]}#{col}"
		end
end
