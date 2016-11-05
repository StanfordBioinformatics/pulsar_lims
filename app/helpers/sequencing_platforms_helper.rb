module SequencingPlatformsHelper
  def sorted_sequencing_platform_name_id
    sequencing_platforms_name_id = SequencingPlatform.all.map{ |x| [x.name,x.id] }
    sequencing_platforms_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return sequencing_platforms_name_id
  end 
end
