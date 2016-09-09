module DocumentsConcern
  extend ActiveSupport::Concern
  
  private

	
  def add_documents(model_obj,documents)
    """ 
    Function : Adds associations to Documents that are stored in self.documents.
    Args     : model_obj - array of Document IDs.
    """
    if documents.blank?
      return model_obj
    end 
    documents.each do |d| 
      if not d.empty?
        doc = Document.find(d)
        if not model_obj.documents.include? doc 
          model_obj.documents << doc 
        end 
      end 
    end 
		return model_obj
  end 
  
  def remove_documents(model_obj,documents)
    """ 
    Function : Removes associations to Documents that are stored in self.documents.
    Args     : document_ids - array of Document IDs.
    """
    if documents.blank?
      return model_obj
    end 
    documents.each do |d| 
      doc = Document.find(d)
      if model_obj.documents.include? doc 
        model_obj.documents.destroy(doc)
      end 
    end 
		return model_obj
  end 
end
