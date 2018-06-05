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

  def link_to_record_id(record)
    record_id = record.get_record_id()
    dest = record
    if record.respond_to?(:params_for_url_for)
      dest = record.params_for_url_for()
    end
    return link_to record_id, dest
  end

  def link_to_record(record)
    display = record.display()
    dest = record
    if record.respond_to?(:params_for_url_for)
      dest = record.params_for_url_for()
    end
    return link_to display,dest
  end

  def if_signed_in(&block)
    block.call if current_user
  end

  def admins_only(&block)
    block.call if current_user.try(:admin?)
  end

end  
