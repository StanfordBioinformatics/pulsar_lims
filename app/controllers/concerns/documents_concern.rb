module DocumentsConcern
  extend ActiveSupport::Concern
  
  private

	
#  def add_documents(model_obj,documents)
#    """ 
#    Function : Adds associations to Documents that are stored in self.documents.
#    Args     : model_obj - array of Document IDs.
#    """
#    if documents.blank?
#      return model_obj
#		elsif documents.is_a?(String)
#			documents = Array(documents)
#    end 
#    documents.each do |d| 
#      if not d.empty?
#        doc = Document.find(d)
#        if not model_obj.documents.include? doc 
#          model_obj.documents << doc 
#        end 
#      end 
#    end 
#		return model_obj
#  end 
end
