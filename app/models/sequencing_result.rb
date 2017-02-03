class SequencingResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :sequencing_request
	belongs_to :report, class_name: "Document"

	validates :run_name, presence: true

	def self.policy_class
		ApplicationPolicy
	end
end
