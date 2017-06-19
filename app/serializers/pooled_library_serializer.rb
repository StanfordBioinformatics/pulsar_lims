class PooledLibrarySerializer < ActiveModel::Serializer
  attributes :id, :name, :paired_end, :size_range
  has_one :user
  has_one :sequencing_library_prep_kit
end
