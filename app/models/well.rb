class Well < ActiveRecord::Base
	#has_one :biosample, dependent: :destroy #i.e. in single cell experiments. Each sorted cell is a biosample in a well.
	has_one :biosample, dependent: :destroy
  belongs_to :user
  belongs_to :plate

	validates :row, presence: true
	validates :col, presence: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end

	def get_name 
		return "#{Plate::row_letter(self.row)}#{col}"
	end

	private

	def set_name
		self.name = get_name
	end

end
