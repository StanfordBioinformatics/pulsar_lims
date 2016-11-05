module SequencingCentersHelper
  def sorted_sequencing_center_name_id
    sequencing_centers_name_id = SequencingCenter.all.map{ |x| [x.name,x.id] }
    sequencing_centers_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return sequencing_centers_name_id
  end 
end
