module ModelConcerns

  def get_record_id
    return "#{self.class::ABBR}-#{self.id}"
  end

  def display
    if self.respond_to?(:name)
      return self.name
    else
      return self.get_record_id()
    end
  end
end
