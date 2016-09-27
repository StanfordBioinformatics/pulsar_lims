class Organism < ActiveRecord::Base
	has_many :antibodies
	validates :name, uniqueness: true, presence: true
end
