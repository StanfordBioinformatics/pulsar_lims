class Well < ActiveRecord::Base
	#has_one :biosample, dependent: :destroy #i.e. in single cell experiments. Each sorted cell is a biosample in a well.
	has_one :biosample, dependent: :destroy, validate: true
  belongs_to :user
  belongs_to :plate

	validates :row, presence: true
	validates :col, presence: true
	validates_uniqueness_of :row, scope: [:plate_id, :col]
	validates_uniqueness_of :name, scope: :plate_id

	scope :persisted, lambda { where.not(id: nil) }
	before_create :set_name
	after_create  :add_biosample

	def self.policy_class
		ApplicationPolicy
	end

	def get_name 
		return "#{Plate::row_letter(self.row)}#{col}"
	end

	def get_prototype_biosample_for_well
		#A helpler used for updating or creating a well biosample.
		#Since the single_cell_sorting.sorting_biosample is duplicated as a 
		#starting point for creating or updating a new well biosample, several fields need to be filtered out,
		#such as the original id and well id, to name a few. When the user updates the sorting biosample,
		#all well biosamples need to be updated based on what the updated sorting biosample looks like.
		#In this case, we'll again need to call this method to filter out properties that we shouldn't explicitly
		#set.
		sorting_biosample = self.plate.single_cell_sorting.sorting_biosample #the prototype biosample on the plate
		well_biosample = sorting_biosample.dup
		well_biosample.documents = sorting_biosample.documents
		well_biosample.name = self.plate.single_cell_sorting.name + " " + self.plate.name + " " +  self.get_name #(sorting exp name) + (plate name) + (well name)
		attrs = well_biosample.attributes
		attrs["user"] = self.user
		attrs["prototype"] = false #this should always be false for a well biosample
		#Remove attributes that shouldn't be explicitely set for the well biosample
		attrs.delete("name") #the name is expicitely set in the biosample model when it has a well associated.
		attrs.delete("id")
		attrs.delete("well_id")
		attrs.delete("created_at")
		attrs.delete("updated_at")
		return attrs
	end

	def update_biosample_from_prototype
		biosample_attrs = self.get_prototype_biosample_for_well
		biosample = self.biosample.update(biosample_attrs)
	end

	private

	def add_biosample
		biosample_attrs = self.get_prototype_biosample_for_well
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
