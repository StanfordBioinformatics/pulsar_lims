class Donor < ActiveRecord::Base
	ABBR = "DON"
	DEFINITION = "The donor of a biosample, whether human or some other type of organism. Currently, this linkes to an accession from a consortium, such as an ENCODE Donor, i.e. see https://www.encodeproject.org/donors/.  Model abbreviation: #{ABBR}"
	has_many :biosamples
	belongs_to :user
	validates :encode_identifier, uniqueness: true, presence: true
	validates :name, length: { minimum: 2, maximum: 40 }, uniqueness: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end 
end
