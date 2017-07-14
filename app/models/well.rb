class Well < ActiveRecord::Base
	#has_one :biosample, dependent: :destroy #i.e. in single cell experiments. Each sorted cell is a biosample in a well.
	has_one :biosample, dependent: :destroy
  belongs_to :user
  belongs_to :plate

	validates :row, presence: true
	validates :col, presence: true
	validates_uniqueness_of :name, scope: :plate_id

	scope :persisted, lambda { where.not(id: nil) }
	before_create :set_name

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
