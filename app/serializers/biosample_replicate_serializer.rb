class BiosampleReplicateSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :biological_replicate_number, :biosample_id, :chipseq_experiment_id, :control, :notes, :technical_replicate_number, :upstream_identifier, :wild_type_input, :upstream_identifier, :created_at, :updated_at
  has_one :user
end