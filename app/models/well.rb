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
		starting_biosample = self.plate.single_cell_sorting.starting_biosample
		sub_biosample = starting_biosample.dup
		#the dup() method doesn't establish the has_one or has_many associations. So will need to explicitely set those. 
		sub_biosample.parent_biosample = starting_biosample
		sub_biosample.name = starting_biosample.name + "_" + self.plate.name + "_" +  self.row.to_s + "-" + self.col.to_s
		sub_biosample.documents = starting_biosample.documents
		attrs = sub_biosample.attributes
		self.create_biosample!(sub_biosample.attributes.merge!({documents: starting_biosample.documents}))
	end

	def set_name
		self.name = "#{Plate::row_letter(self.row)}#{col}"
	end
end
