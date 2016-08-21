class Uberon < ActiveRecord::Base
	validates :name, :accession, presence: true
	validates :accession, uniqueness: true
end
