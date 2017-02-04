class LibrarySequencingResultSerializer < ActiveModel::Serializer
  attributes :id, :name, :comment, :read1_uri, :read2_uri, :read1_count, :read2_count
  has_one :sequencing_result
  has_one :library
end
