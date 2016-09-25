class Library < ActiveRecord::Base
	has_and_belongs_to_many :documents
  belongs_to :nucleic_acid_term
  belongs_to :biosample
  belongs_to :antibody
  belongs_to :vendor
	belongs_to :user

	validates :name, length: { maximum: 20 }, presence: true, uniqueness: true
	validates  :size_range, format: {with: /\A\d+-\d+\Z/}, presence: true
	validates :nucleic_acid_term_id, :biosample_id, :vendor_id,  presence: true
	#The fkey antibody_id doesn't need to be required since some libraries, such as ATAC-SEq, don't have an antibody.

end
