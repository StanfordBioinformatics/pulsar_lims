module DonorsHelper
  def sorted_donor_name_id
    donors_name_id = Donor.all.map{ |x| [x.name,x.id] }
    donors_name_id.sort! do |x,y|
      x[0] <=> y[0]
     end 
    return donors_name_id
	end
end
