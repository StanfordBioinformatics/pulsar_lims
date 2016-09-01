class Vendor < ActiveRecord::Base
	has_many :biosample
	has_many :antibodies
	has_many :libraries
end
