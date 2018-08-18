class SingleCellSortingSerializer < ActiveModel::Serializer
  self.root = false
  #embed :ids

  attributes :id,
             :description,
             :fluorescence_intensity_file,
             :name,
             :notes,
             :upstream_identifier,
             :created_at,
             :updated_at

  has_many :analyses
  has_many :documents
  has_many :plates
  has_many :sequencing_requests
  #has_one  :library_prototype 
  #Don't add library_prototype since that is accessed via the sorting_biosample.
  # Furthermore, it'll cause an error if including it that reads:
  #     NoMethodError (undefined method `read_attribute_for_serialization' for "":String):.
  #      app/controllers/api/single_cell_sortings_controller.rb:25:in `show'
  # That is likely due to the fact that sorting_biosample already includes this library.
  #has_one  :library_prototype 
  has_one  :sorting_biosample
  has_one  :starting_biosample
  has_one  :user

end
