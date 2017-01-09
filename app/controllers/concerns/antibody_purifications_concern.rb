module AntibodyPurificationsConcern 
  extend ActiveSupport::Concern
  
  private

  def add_antibody_purifications(model_obj,purifications)
    """ 
    Function : Adds AntibodyPurification associations to the self.antibody_purifications attr. 
    Args     : purification - Array of AntibodyPurification primary key IDs.
    """
    if purifications.blank?
      return model_obj
    end 
    purifications.each do |p| 
      if not p.empty?
        pur = AntibodyPurification.find(p)
        if not model_obj.antibody_purifications.include? pur 
          model_obj.antibody_purifications << pur 
        end 
      end 
    end 
		return model_obj
  end 

end
