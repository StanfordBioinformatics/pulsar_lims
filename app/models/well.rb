class Well < ActiveRecord::Base
	belongs_to  :biosample #i.e. in single cell experiments. Each sorted cell is a biosample in a well. Not required.
  belongs_to :user
  belongs_to :plate

	validates :row, presence: true
	validates :col, presence: true

	before_create :set_name

	def self.policy_class
		ApplicationPolicy
	end

	def set_biosample 
		#well belongs to a plate that belongs to a single-cell sorting experiment.
		plate_biosample = self.plate.starting_biosample
		sub_biosample = plate_biosample.dup
		sub_biosample.name = plate_biosample.name + "_" + self.plate.name + "_" +  self.row.to_s + "-" + self.col.to_s
		sub_biosample.documents = plate_biosample.documents
		attrs = sub_biosample.attributes
		puts attrs
		self.create_biosample!(sub_biosample.attributes.merge!({documents: plate_biosample.documents}))
	end

	protected
		def set_name
			self.name = "#{Plate::row_letter(self.row)}#{col}"
		end
end
