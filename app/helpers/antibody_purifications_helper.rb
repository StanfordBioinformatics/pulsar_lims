module AntibodyPurificationsHelper
	def sorted_antibody_purification_name_id
    @purifications_name_id = AntibodyPurification.all.map{ |x| [x.name,x.id] }
    @purifications_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return @purifications_name_id
	end
end
