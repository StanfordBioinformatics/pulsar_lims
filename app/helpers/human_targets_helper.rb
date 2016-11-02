module HumanTargetsHelper
  def sorted_target_name_id
    @targets_name_id = HumanTarget.all.map{ |x| [x.encode_identifier,x.id] }
    @targets_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @targets_name_id
  end
end
