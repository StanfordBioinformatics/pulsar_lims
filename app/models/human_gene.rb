class HumanGene < ActiveRecord::Base
	validates :encode_identifier, uniqueness: true
end
