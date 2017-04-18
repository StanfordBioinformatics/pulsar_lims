class Plate < ActiveRecord::Base
  belongs_to :user
  belongs_to :sequencing_library_prep_kit
  belongs_to :vendor

	def self.policy_class
		ApplicationPolicy
	end
end
