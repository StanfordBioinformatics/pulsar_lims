class Well < ActiveRecord::Base
	#has_one :biosample, dependent: :destroy #i.e. in single cell experiments. Each sorted cell is a biosample in a well.
	has_one :biosample, dependent: :destroy
  belongs_to :user
  belongs_to :plate

	validates :row, presence: true
	validates :col, presence: true

	before_create :set_name
	after_create  :add_biosample

	def self.policy_class
		ApplicationPolicy
	end

	private

	def add_biosample 
		#well belongs to a plate that belongs to a single-cell sorting experiment.
		# Grab the prototype biosample (single_cell_sorting.sorting_biosample)
		sorting_biosample = self.plate.single_cell_sorting.sorting_biosample
		sub_biosample = sorting_biosample.dup
		#the dup() method doesn't set the has_one or has_many associations. So will need to explicitely set those. 
		sub_biosample.name = sorting_biosample.name + "_" + self.plate.name + "_" +  get_name
		sub_biosample.documents = sorting_biosample.documents
		attrs = sub_biosample.attributes
		#self.create_biosample!(sub_biosample.attributes.merge!({documents: sorting_biosample.documents}))
		self.create_biosample!(sub_biosample.attributes)
	end

	def set_name
		self.name = get_name
	end

	def get_name 
		return "#{Plate::row_letter(self.row)}#{col}"
	end
end
