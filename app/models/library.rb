class Library < ActiveRecord::Base
	has_and_belongs_to_many :documents
  belongs_to :nucleic_acid_term
  belongs_to :biosample
  belongs_to :vendor
	belongs_to :antibody
	belongs_to :user

	validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
	validates  :size_range, format: {with: /\A\d+-\d+\Z/}
	validates :nucleic_acid_term_id, :biosample_id, :vendor_id,  presence: true
	validates :documents, presence: true
	validates :vendor_id, presence: true
	validates :biosample_id, presence: true
	#The fkey antibody_id doesn't need to be required since some libraries, such as ATAC-SEq, don't have an antibody.

end
