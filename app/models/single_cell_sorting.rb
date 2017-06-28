class SingleCellSorting < ActiveRecord::Base
	belongs_to :sorting_biosample, class_name: "Biosample"
	belongs_to :starting_biosample, class_name: "Biosample"
  belongs_to :user
	has_many :plates, dependent: :destroy

	validates :name, presence: true, uniqueness: true
	validates :starting_biosample, presence: true #single cell sorting exp. must start with a biosample having cells to sort.

	def self.policy_class
		ApplicationPolicy
	end
end
