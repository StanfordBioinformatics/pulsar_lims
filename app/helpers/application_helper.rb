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

  def get_record_id(record)
    return "#{record.class::ABBR}-#{record.id}"
  end

  def link_to_record_id(record)
    record_id = get_record_id(record)
    param = record
    if record.respond_to?(:params_for_url_for)
      param = record.params_for_url_for()
    end
    return link_to record_id,param
  end

	def if_signed_in(&block)
		block.call if current_user
	end

	def admins_only(&block)
		block.call if current_user.try(:admin?)
	end

end	
