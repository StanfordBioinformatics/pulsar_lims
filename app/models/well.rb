class Well < ActiveRecord::Base
	#has_one :biosample, dependent: :destroy #i.e. in single cell experiments. Each sorted cell is a biosample in a well.
	has_one :biosample, dependent: :destroy, validate: true
  belongs_to :user
  belongs_to :plate

	validates :row, presence: true
	validates :col, presence: true
	validates_uniqueness_of :row, scope: [:plate_id, :col]
	validates_uniqueness_of :name, scope: :plate_id
	validate :validate_location

	scope :persisted, lambda { where.not(id: nil) }
	before_validation :set_name
	after_create  :add_biosample

	def self.policy_class
		ApplicationPolicy
	end

	def get_name 
		return "#{Plate::row_letter(self.row)}#{col}"
	end

	def get_library
		return self.biosample.libraries.first
	end

  def add_library_to_biosample(biosample)
		if not biosample.well.plate.id == self.plate.id
			raise "Invalid biosample #{biosample.name} does not exist on the same Plate as does this Well #{well.name}."
		end
    library_attrs = Library.instantiate_prototype(self.plate.single_cell_sorting.library_prototype)
    library = biosample.libraries.create(library_attrs)
    #I first tried using create_biosample!, which did raise ActiveRecord:RecordInvalid. However,
    # while that does issue a Rollback as expected as any exception would in a callback, the form errors appear to be gone
    # and don't display on the form. Thus, the user is left with a re-rendered and populated form w/o any indication
    # of what happened.
    if not library.valid?
      raise "Unable to create library for biosample #{biosample.name}: #{library.errors.full_messages}"
      #throws a RuntimeError 
    end 
  end

	private

	def validate_location
		row = self.row
		col = self.col
		row_valid = (row > 0) && (row <= self.plate.nrow)
		if not row_valid
			self.errors[:row] << "Must be > 0 and <= the number of rows on the plate."
			return false
		end
		col_valid = (col > 0) && (col <= self.plate.ncol)
		if not col_valid
			self.errors[:col] << "Must be > 0 and <= the number of columns on the plate."
			return false
		end
		return true
	end

	def add_biosample
		biosample_attrs = Biosample.instantiate_prototype(self.plate.single_cell_sorting.sorting_biosample)
		biosample = self.create_biosample(biosample_attrs)
		#I first tried using create_biosample!, which did raise ActiveRecord:RecordInvalid. However,
		# while that does issue a Rollback as expected as any exception would in a callback, the form errors appear to be gone
		# and don't display on the form. Thus, the user is left with a re-rendered and populated form w/o any indication
		# of what happened.
		if not biosample.valid?
			raise "Unable to create biosample for well #{self.name}: #{biosample.errors.full_messages}"
			#throws a RuntimeError that I catch in single_cell_sortings_controller.rb in the update() method.
		end
	end

	def set_name
		self.name = get_name
	end

end
