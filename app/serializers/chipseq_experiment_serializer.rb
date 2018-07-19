class ChipseqExperimentSerializer < ActiveModel::Serializer
  self.root = false
  embed :ids

  attributes :id, :document_ids, :description, :name, :notes, :submitter_comments, :target_id, :upstream_identifier, :wild_type_input_id, :upstream_identifier, :created_at, :updated_at


  has_one :user
  has_one :target
  has_many :control_biosample_replicates
  #has_many :documents
  has_many :experiment_biosample_replicates
end
