class SingleCellSortingSerializer < ActiveModel::Serializer
  self.root = false

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
  has_one  :library_prototype 
  has_one  :sorting_biosample
  has_one  :starting_biosample
  has_one  :user

end
