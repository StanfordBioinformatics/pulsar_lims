module BiosamplesHelper
  def sorted_biosample_name_id
    @biosamples_name_id = Biosample.all.map{ |x| [x.name,x.id] }
    @biosamples_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @biosamples_name_id
  end 

end
