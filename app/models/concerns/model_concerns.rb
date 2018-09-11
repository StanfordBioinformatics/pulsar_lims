module ModelConcerns

  def get_record_id
    return "#{self.class::ABBR}-#{self.id}"
  end

  def to_label 
    # This method is looked up by simple_form and if found is used as the labeling method for
    # items in a selection list.
    label = self.get_record_id
    if self.respond_to?(:name)
      name = self.name
      if name.present?
        label += " #{name}"
      end
    end
    return label
  end

  def display
    if self.respond_to?(:name)
      # The 'name' attribute isn't all all objects, and isn't required for all Models that have it,
      # although it is for most.
      if self.name.present?
        return self.name
      end
    end
    return self.get_record_id()
  end
end
