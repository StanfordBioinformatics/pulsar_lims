module ModelConcerns

  def get_record_id
    return "#{self.class::ABBR}-#{self.id}"
  end

  def to_label 
    # This method is looked up by simple_form and if found is used as the labeling method for
    # items in a selection list.
    label = self.get_record_id
    if self.send(:name)
      name = self.name
      if name.present?
        label += " #{name}"
      end
    end
    return label
  end

  def display
    if self.respond_to?(:name)
      return self.name
    else
      return self.get_record_id()
    end
  end
end
