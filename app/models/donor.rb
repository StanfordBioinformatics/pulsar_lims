class Donor < ActiveRecord::Base
	has_many :biosamples
	validates :encode_identifier, uniqueness: true
end
