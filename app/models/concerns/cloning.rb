module Cloning
  extend ActiveSupport::Concern

  included do
    # This is the only way I know how to add callbacks in a concern; see blog article at https://medium.com/@RyanDavidson/add-callbacks-to-a-concern-in-ruby-on-rails-ef1a8d26e7ab.
    #before_save :validate_prototype
    after_update :propagate_update_if_prototype
  end

  def part_of_chain
    """
    Finds all ancestors of the given model that are linked together via the part_of_id record attribute.
    For example, Biosample C can be part_of Biosample B, which in turn can be part_of Biosample A. 
    Additionally the from_prototype attribute is also checked. Normally, when, say, a Biosample is cloned, the new
    Biosample will have a part_of_id attribute and a from_prototype attribute both pointing to the parent.
    Having the from_prototype set means that when the parent's attributes change, the child's attributes
    will also be updated to reflect that (the attributes that can be tracked in this manner are specified
    in a model method by the name of attributes_for_cloning). Sometimes, there are situations where
    a record doesn't have the part_of attribute set, but the from_prototype is set. This scenario 
    occurs in SingleCellSortings regarding the Library prototype. The Library prototype is a
    virtual Library that is cloned each time a new Library needs to be linked to a Biosample in a 
    Well of a Plate. This method currently being documented is called in the Library show view 
    (again, imagine a Library of a Biosample linked to a Well) to list any protocol Documents 
    that are linked to itself and to any ancestral Libraries - a handy feature that lets us avoid 
    having to re-associate the same Documents to each Library manually. 

    The view pages for a record that has any such ancestors may (at the business logic of each model's discretion)
    display the ancestor's attributes in its views. For example, given 
    a record that is a Biosample, it may have no Treatments declared directly on the record. However,
    if it has an ancestor with an associated Treatment, then that ancestor's Treatment will be displayed
    on the view pages for the record. Thus, the main purpose for this method is for views to consult
    when desired whether a given record has ancestors, and if so, whether to display the ancestory attributes
    for one or more associations. 

    Parent relationships are established via use of the foreign keys 'part_of_id' and 'from_prototype_id'. 
    This check is recursive - if such an ancestor exists, it will in turn be checked for a one, 
    and all found ancestorys will be part of the returned array. If the record's model doesn't define 
    such foreign keys to itself, then the result will always be an empty array.

    Returns:
        Array of sibling records of the same class.
    """
    chain = []
    # Add chain from any part-of relationships in this single-parent ancestor chain.
    if self.respond_to?(:part_of)
      parent = self.part_of
      while parent.present?
        chain << parent
        parent = parent.part_of
      end
    end

    # Add chain from any prototoype in this single-parent ancestor chain.
    # I can't imagine a scenario where it would be useful to have more than one ancestor that is
    # a prototype, but it's possible to do so should check for it.
    if self.respond_to?(:from_prototype)
      parent = self.from_prototype
      while parent.present?
        if not chain.include?(parent)
          chain << parent
        end
        parent = parent.from_prototype
      end
    end
    return chain
  end

  def update_from_sibling(sibling_id)
    """
    Updates the current record with the attributes of the specified sibling record.
    The record's class should provide an instance method called attributes_for_cloning() that 
    determines which attributes can be used to udpate a sibling record. 

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

  # Make this method private since Models have their own clone instance method named in the format
  # clone_model that calls this one, where model is the lower-cased class name of the model with 
  # underscores instead of camelcase. There is no need to call this class or those that follow outside
  # of model code. 
  def clone(associated_user_id:, custom_attrs:)
    amount_cloned = self.times_cloned + 1
    attrs = self.attributes_for_cloning()
    attrs["user_id"] = associated_user_id
    attrs["name"] = "#{self.name} clone #{amount_cloned}"
    if custom_attrs.present?
      attrs.update(custom_attrs)
    end
    new_record = self.class.create!(attrs)
    #The above create! class method raises ActiveRecord::RecordInvalid if there is any validation error, and
    # this is caught in application_controller.rb.
    self.update_column(:times_cloned, amount_cloned)
    # use update_column() above so as not to trigger callbacks.  That is a problem otherwise, b/c
    # when updating this prototype object, we don't need the after_update callback for propagate_update_if_prototype() to run.
    return new_record
  end

  def propagate_update_if_prototype
    # An after_update callback.
    # If this is a prototype record, then we need to propagate the update to dependent, sibling 
    # records of the same model.
    #
    # For example, in the case of a SingleCellSorting, the sorting_biosample is a prototype since it
    # is used to define what the sorted biosamples in each well should look like (each well has a 
    # single biosample and such a biosample has a single library).
    # This makes updating all of the biosample objects with regard to all the plates on a single_cell_sorting
    # easy to do just by changing the biosample prototype assocated with the single_cell_sorting.
    if self.prototype_instances.any?
      cloning_attrs = self.attributes_for_cloning()
      first_prototype_instance = self.prototype_instances[0]
      fpi_cloning_attrs = first_prototype_instance.attributes_for_cloning()
      if cloning_attrs == fpi_cloning_attrs
        # No need to update all instances if the update to the prototype was on a field that isn't
        # propagated.
        return
      else
        self.prototype_instances.each do |pi|
          pi.update_from_sibling(self.id)
        end
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

