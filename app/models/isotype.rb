class Isotype < ActiveRecord::Base
	has_many :antibodies
	validates :name, presence: true, uniqueness: true
end
