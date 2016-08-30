class HumanGene < ActiveRecord::Base
	has_many :antibodies
	validates :encode_identifier, uniqueness: true
end
