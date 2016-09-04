module BiosampleTypesHelper
  def sorted_biosampletype_name_id
    @biosampletypes_name_id = BiosampleType.all.map{ |x| [x.name,x.id] }
    @biosampletypes_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @biosampletypes_name_id
  end 
	
end
