class ChipseqExperimentSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :document_ids,
             :description,
             :name,
             :notes,
             :submitter_comments,
             :target_id,
             :chipseq_starting_biosample_ids,
             :upstream_identifier,
             :upstream_identifier,
             :wild_type_control_id,
             :created_at,
             :updated_at


  has_one :user
  has_many :control_replicates
  has_many :replicates
  has_many :chipseq_starting_biosamples
  #has_many :documents
end
