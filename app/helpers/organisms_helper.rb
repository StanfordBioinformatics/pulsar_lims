module OrganismsHelper
	def sorted_organism_name_id
		@organisms_name_id = Organism.all.map{ |x| [x.name,x.id] }
		@organisms_name_id.sort! do |x,y|
			x[0] <=> y[0]
		 end 
		return @organisms_name_id
	end 
  
end
