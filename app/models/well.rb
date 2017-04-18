class Well < ActiveRecord::Base
	ROW_LETTERS = ("A".."Z").to_a
  belongs_to :user
  belongs_to :plate
  belongs_to :barcode
  belongs_to :paired_barcode

	validates :row, presence: true
	validates :col, presence: true

	before_create :set_name
	before_save :verify_barcodes


	protected	
		def set_name
			self.name = "#{ROW_LETTERS[self.row - 1]}#{col}"
		end

    def verify_barcodes
      if self.barcode.present? and self.paired_barcode.present?
        self.errors.add(:base, "Can't specify both the \"barcode\" attribute (which is used only for single-end libraries) and the \"paired_barcode\" attribute (which is used only for paired-end libraries).")
        return false
      elsif self.barcode.present? and self.paired_end?
        self.errors.add(:base, "Can't set single-end barcode when the library is marked as paired-end. You must instead select paired-end barcode.")
        return false
      elsif self.paired_barcode.present? and not self.paired_end?
        self.errors.add(:base, "Can't set paired-end barcode when the library is not marked as paired-end. You must instead select single-end barodes.")
        return false
      end 
    end

end
