module LibrariesHelper
def sorted_library_name_id
  @libraries_name_id = Library.all.map{ |x| [x.name,x.id] }
  @libraries_name_id.sort! do |x,y|
    x[0] <=> y[0]
   end 
  return @libraries_name_id
  end 
end
