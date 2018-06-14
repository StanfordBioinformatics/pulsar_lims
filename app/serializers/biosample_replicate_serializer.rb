class BiosampleReplicateSerializer < ActiveModel::Serializer
  attributes :id, :name, :upstream_identifier, :biological_replicate_number, :technical_replicate_number, :notes
  has_one :user
end
