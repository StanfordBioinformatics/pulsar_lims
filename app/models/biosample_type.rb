class BiosampleType < ActiveRecord::Base
	validates :name, presence: true
end
