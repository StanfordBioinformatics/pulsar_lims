class HumanDonor < ActiveRecord::Base
	has_one :biosample
	validates :encode_identifier, uniqueness: true
end
