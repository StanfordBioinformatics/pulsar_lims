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

	def self.policy_class
		ApplicationPolicy
	end

	def get_name 
		return "#{Plate::row_letter(self.row)}#{col}"
	end

	def add_or_update_biosample(prototype)
		#Updates or creates a biosample in a well, based on the state of the biosample prototype linked to the single_cell_sorting.
		#sorting_biosample = self.plate.single_cell_sorting.sorting_biosample
		sorting_biosample = prototype
		sub_biosample = sorting_biosample.dup
		sub_biosample.user = self.user
		sub_biosample.prototype = false
		sub_biosample.documents = sorting_biosample.documents
		sub_biosample.name = self.plate.single_cell_sorting.name + " " + self.plate.name + " " +  self.get_name #(sorting exp name) + (plate name) + (well name)
    attrs = sub_biosample.attributes
		attrs.delete("id")
		attrs.delete("well_id")
		attrs.delete("created_at")
		attrs.delete("updated_at")
		attrs["name"] = "marryyy" #test
		if self.biosample.blank?
			#then the biosample is being created
			self.build_biosample(attrs) #No validations run yet. New Biosample object returned (at the same time setting self.biosample).
		else
			#then the bioample is being updated
			#attrs["name"] = "marry" #test
			res = self.biosample.update(attrs) #returns true or false. Validations are already run so any errors would be set by now. 
		end
#		if self.biosample.errors.any?
#			self.biosample.errors.full_messages.each do |msg| 
#				logger.info("tatag")
#				logger.info(msg)
#				logger.info("bb #{self.get_name}")
#				self.errors["well -> biosample:"] <<  msg
#			end 
#		end
	end

	private

	def set_name
		self.name = get_name
	end

end
