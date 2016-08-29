class BiosampleType < ActiveRecord::Base
	has_one :biosample
	validates :name, presence: true
end
