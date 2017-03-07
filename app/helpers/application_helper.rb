module ApplicationHelper
	def title(*parts)
		unless parts.empty?
			content_for :title do 
				(["Pulsar"] << parts).join("-")
			end
		end
	end

	def encode_url(accession)
		return ["https://www.encodeproject.org",accession].join("/")
	end

	def if_signed_in(&block)
		block.call if current_user
	end

	def admins_only(&block)
		block.call if current_user.try(:admin?)
	end

end	
