class ChipseqExperimentSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :description, :name, :notes, :submitter_comments, :target_id, :upstream_identifier, :wild_type_input_id, :control_biosample_replicate_ids => [], :experiment_biosample_replicate_ids => [], :upstream_identifier, :created_at, :updated_at


  has_one :user
  has_one :target
end
