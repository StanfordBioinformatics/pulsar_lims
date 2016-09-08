class Biosample < ActiveRecord::Base
	has_and_belongs_to_many :documents
	belongs_to  :biosample_type
	belongs_to  :human_donor
  belongs_to  :vendor
	has_many    :libraries
	
	validates :name, length: { maximum: 20 }, presence: true, uniqueness: true
	validates :ontology_term_accession, format: {with: /\A(UBERON|EFO|CL|NTR|FBbt|WBbt):[0-9]{2,8}\Z/}, presence: true
	validates :documents, :biosample_type_id, :vendor_id, :human_donor_id, presence: true

	def add_documents(document_ids)
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
	
	def remove_documents(document_ids)
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
