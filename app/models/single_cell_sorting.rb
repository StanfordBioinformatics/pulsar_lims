class SingleCellSorting < ActiveRecord::Base
  include ModelConcerns
	ABBR = "SCS"
	DEFINITION = "Any single cell sorting type of experiment that results in one or more Plates, where each well on a plate contains a single cell. This can be used in the context of scATAC-Seq, or scRNA-Seq, for example.  Model abbreviation: #{ABBR}"
	belongs_to :library_prototype, class_name: "Library", dependent: :destroy
	#the library_prototype is used as a template for creating library objects for each biosample in each well of each plate.
	belongs_to :sorting_biosample, class_name: "Biosample", dependent: :destroy
	belongs_to :starting_biosample, class_name: "Biosample"
  belongs_to :user
	has_many :analyses, dependent: :destroy
	has_many :plates, dependent: :destroy
  has_and_belongs_to_many :documents

  validates  :upstream_identifier, uniqueness: true, allow_nil: true 
	validates :name, presence: true, uniqueness: true
	validates :starting_biosample, presence: true #single cell sorting exp. must start with a biosample having cells to sort.

  accepts_nested_attributes_for :documents, allow_destroy: true
	accepts_nested_attributes_for :sorting_biosample, allow_destroy: true
	accepts_nested_attributes_for :plates, allow_destroy: true
	accepts_nested_attributes_for :library_prototype, allow_destroy: true

	scope :persisted, lambda { where.not(id: nil) }

	def self.policy_class
		ApplicationPolicy
	end

  def document_ids=(ids)
    """ 
    Function : Adds associations to Documents that are stored in self.documents.
    Args     : ids - array of Document IDs.
    """
    ids.each do |i| 
      if i.blank?
        next
      end 
      doc = Document.find(i)
      if not self.documents.include? doc 
        self.documents << doc 
      end 
    end 
  end
end
