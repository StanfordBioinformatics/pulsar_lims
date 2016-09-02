module AntibodiesHelper
  def sorted_antibody_name_id
    @antibodies_name_id = Antibody.all.map{ |x| [x.name,x.id] }
    @antibodies_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @antibodies_name_id
  end 
end
