class ChipseqExperimentSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, 
             :document_ids,
             :description,
             :name,
             :notes,
             :submitter_comments,
             :target_id,
             :upstream_identifier,
             :upstream_identifier,
             :created_at,
             :updated_at


  has_one :user
  has_one :starting_biosample
  has_one :target
  has_one :wild_type_control
  has_many :control_replicates
  has_many :replicates
  #has_many :documents
end
