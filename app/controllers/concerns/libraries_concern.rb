module LibrariesConcern
  extend ActiveSupport::Concern
  
  private


  def add_libraries(model_obj,library_ids)
    """ 
    Function : Adds Libray associations to the self.libraries attr. 
    Args     : library_ids - Array of Library primary key IDs.
    """
    if library_ids.blank?
      return model_obj
    end 
    library_ids.each do |l| 
      if not l.empty?
        record = Library.find(l)
        if not model_obj.libraries.include? record
          model_obj.libraries << record
        end 
      end 
    end 
		return model_obj
  end
end
