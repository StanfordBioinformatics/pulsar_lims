module ApplicationHelper
	def title(*parts)
		unless parts.empty?
			content_for :title do 
				(["SnyderEncode"] << parts).join("-")
			end
		end
	end

	def encode_url(accession)
		return ["https://www.encodeproject.org",accession].join("/")
	end
end
