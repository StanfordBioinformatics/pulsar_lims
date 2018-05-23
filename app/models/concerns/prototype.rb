module Prototype
  extend ActiveSupport::Concern

  included do
    # This is the only way I know how to add callbacks in a concern; see blog article at https://medium.com/@RyanDavidson/add-callbacks-to-a-concern-in-ruby-on-rails-ef1a8d26e7ab.
    before_save :validate_prototype
    after_update :propagate_update_if_prototype
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
        p.update_from_sibling(self.id)
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

