module VendorsHelper
	def sorted_vendor_name_id
		@vendors_name_id = Vendor.all.map{ |x| [x.name,x.id] }
		@vendors_name_id.sort! do |x,y|
			x[0] <=> y[0]
		end
		return @vendors_name_id
	end
	
end
