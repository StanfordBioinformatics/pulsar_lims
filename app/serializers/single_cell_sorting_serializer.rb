class SingleCellSortingSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
             :description,
             :fluorescence_intensity_file,
             :library_prototype_id,
             :name,
             :notes,
             :sorting_biosample,
             :starting_biosample,
             :upstream_identifier,
             :user_id,
             :created_at,
             :updated_at

  has_many :analyses
  has_many :documents
  has_many :plates
  has_many :sequencing_requests

end
