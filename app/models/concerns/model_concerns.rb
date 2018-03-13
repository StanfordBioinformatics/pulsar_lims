module ModelConcerns
 
  def upstream=(val)                                                                                   
    #Most models have the :upstream attribute to track the corresponding object in an upstram          
    # database that we track, i.e. ENCODE Portal. In these models, the :upstream attribute             
    # has a unique index. Since Null values are allowed in a unique index (at least in Postgres        
    # and MySQL, but not empty string values, we'll need to check for the presence of :upstream,       
    # and if present with a blank string, we'll set it to nil.                                         
    upstream = nil                                                                                     
  end  

end
