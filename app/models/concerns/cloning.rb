module Cloning
  extend ActiveSupport::Concern

  included do
    # This is the only way I know how to add callbacks in a concern; see blog article at https://medium.com/@RyanDavidson/add-callbacks-to-a-concern-in-ruby-on-rails-ef1a8d26e7ab.
    before_save :validate_prototype
    after_update :propagate_update_if_prototype
  end


  def clone(associated_user_id:, custom_attrs:)
    times_cloned = self._times_cloned + 1
    attrs = self.attributes_for_cloning()
    attrs["user_id"] = associated_user_id
    attrs["name"] = "#{self.name} clone #{times_cloned}"
    if custom_attrs.present?
      attrs.update(custom_attrs)
    end
    new_record = self.class.create!(attrs)
    #The above create! class method raises ActiveRecord::RecordInvalid if there is any validation error, and
    # this is caught in application_controller.rb.
    self.update!({_times_cloned: times_cloned })
    return new_record
  end

  def parents
    """
    Looks for sibling records of the same model that are considered to be parents of the current record.
    The view pages for a record that has any parents may (at the business logic of each model's discretion)
    display the parent's attributes in its views. For example, given 
    a record that is a biosample, it may have no treatments declared directly on the record. However,
    if it has a parent and that parent has an associated treatment, then that parent's treatment will be displayed
    on the view pages for the record. Thus, the main purpose for this method is for views to consult
    when desired whether a given record has parents, and if so, whether to display the parent attributes
    for one or more associations. 

    Parent relationships are established via use of the foreign keys 'part_of_id' and 'from_prototype_id'
    that are present in the same model (table) as the current record. This check is recursive - if 
    a parent exists, it will in turn be checked for a parent, and all found parents will be part of the
    returned array. If the record's model doesn't define such foreign keys to itself, then the 
    result will always be an empty array.

    Example: A Biosample can have a parent via the part_of relationship when an aliquot is taken from
    a parent to create the child. It is important to point out that if a biosample was creating by being
    pooled from multiple biosamples (indicated by 'pooled_from_biosamples') then the biosamples used 
    in the pooling are not considered parents in this method and hence won't be a part of the resulting array. 

    Returns:
        Array of sibling records of the same class.
    """
    parents = []
    # Add parents from any part-of relationships in this single-parent ancestor chain.
    if self.respond_to?(:part_of)
      parent = self.part_of
      while parent.present?
        parents << parent
        parent = parent.part_of
      end
    end

    # Add parents from any prototoype in this single-parent ancestor chain.
    # I can't imagine a scenario where it would be useful to have more than one ancestor that is
    # a prototype, but it's possible to do so should check for it.
    if self.respond_to?(:from_prototype)
      parent = self.from_prototype
      while parent.present?
        parents << parent
        parent = parent.from_prototype
      end
    end
    return parents
  end

  def update_from_sibling(sibling_id)
    """
    Args:
        sibling: Another record of the same model class.
    """
    model_class = self.class
    sibling = model_class.find(sibling_id)
    attrs = sibling.attributes_for_cloning
    success = self.update(attrs)
    if not success
      raise "Unable to update #{model_class.name} '#{self.name}' based on given sibling record: #{self.errors.full_messages}"
    end
  end

  private

  def propagate_update_if_prototype
    #An after_update callback.
    #If this is a prototype biosample, then we need to propagate the update to dependent biosamples.
    # In the case of single_cell_sorting, dependent biosamples are those sorted into the wells of each plate on the experiment
    # (each well has a single biosample and such a biosample has a single library).
    # This makes updating all of the biosample objects with regard to all the plates on a single_cell_sorting
    # easy to do just by changing the biosample prototype (starting biosample) assocated with the single_cell_sorting.
    if self.prototype_instances.any?
      self.prototype_instances.each do |pi|
        pi.update_from_sibling(self.id)
      end
    end
#    if self.sorting_biosample_single_cell_sorting.present?
#      sorting_biosample_single_cell_sorting.plates.each do |plate|
#        plate.wells.each do |well|
#          well.biosample.update_from_prototype(self)
#        end
#      end
#    end
  end

  def validate_prototype
    # A before_save callback.
    # A library can either be a prototype (virtual library) or an actuated library created based on a library prototype, not both.
    if self.prototype_instances.any? and self.from_prototype.present?
      self.errors[:base] << "Invalid: No support for prototype chain. A record can be a prototype only if it isn't from a prototype."
      return false
    end
  end
end

