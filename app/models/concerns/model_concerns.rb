module ModelConcerns

  def get_record_id
    if self.class == Atacseq && self.single_cell
      return "scAS-#{self.id}"
    else
      return "#{self.class::ABBR}-#{self.id}"
    end
  end

  def to_label 
    # This method is looked up by simple_form and if found is used as the labeling method for
    # items in a selection list.
    label = self.get_record_id
    if self.respond_to?(:name)
      name = self.name
      if name.present?
        label = "#{name} #{label}"
      end
    end
    return label
  end

  def display
    return self.to_label()
  end
end
