class Library < ActiveRecord::Base
	has_and_belongs_to_many :documents
  belongs_to :sequence_ontology_term
  belongs_to :biosample
  belongs_to :antibody
  belongs_to :vendor

	validates :name, length: { maximum: 20 }, presence: true, uniqueness: true
	validates  :size_range, format: {with: /\A\d+-\d+\Z/}, presence: true
	validates :sequence_ontology_term_id, :biosample_id, :vendor_id,  presence: true
	#The fkey antibody_id doesn't need to be required since some libraries, such as ATAC-SEq, don't have an antibody.

  def add_documents(document_ids=[])
    """ 
    Function : Adds associations to Documents that are stored in self.documents.
    Args     : document_ids - array of Document IDs.
    """
		if document_ids.blank?
			return
		end
    document_ids.each do |d| 
      if not d.empty?
        doc = Document.find(d)
        if not documents.include? doc 
          documents << doc 
        end 
      end 
    end 
  end 
  
  def remove_documents(document_ids=[])
    """ 
    Function : Removes associations to Documents that are stored in self.documents.
    Args     : document_ids - array of Document IDs.
    """
		if document_ids.blank?
			return
		end
    document_ids.each do |d| 
      doc = Document.find(d)
      if documents.include? doc 
        documents.destroy(doc)
      end 
    end 
  end 


end
