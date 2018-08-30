class ChipseqExperimentSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :document_ids,
             :description,
             :name,
             :notes,
             :starting_biosample,
             :submitter_comments,
             :target_id,
             :upstream_identifier,
             :upstream_identifier,
             :wild_type_control_id,
             :created_at,
             :updated_at


  has_one :user
  has_many :control_replicates
  has_many :replicates
  #has_many :documents
end
