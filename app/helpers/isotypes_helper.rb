module IsotypesHelper
  def sorted_isotype_name_id
    @isotypes_name_id = Isotype.all.map{ |x| [x.name,x.id] }
    @isotypes_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @isotypes_name_id
  end
end
