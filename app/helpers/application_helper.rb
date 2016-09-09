module ApplicationHelper
	def title(*parts)
		unless parts.empty?
			content_for :title do 
				(["SnyderEncode"] << parts).join("-")
			end
		end
	end
end
