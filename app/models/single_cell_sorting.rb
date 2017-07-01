class SingleCellSorting < ActiveRecord::Base
	belongs_to :sorting_biosample, class_name: "Biosample", dependent: :destroy
	belongs_to :starting_biosample, class_name: "Biosample"
  belongs_to :user
	has_many :plates, dependent: :destroy

	validates :name, presence: true, uniqueness: true
	validates :starting_biosample, presence: true #single cell sorting exp. must start with a biosample having cells to sort.

	accepts_nested_attributes_for :sorting_biosample, allow_destroy: true
	accepts_nested_attributes_for :plates, allow_destroy: true

	def self.policy_class
		ApplicationPolicy
	end
end
