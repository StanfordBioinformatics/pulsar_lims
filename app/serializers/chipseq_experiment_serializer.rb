class ChipseqExperimentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :upstream_identifier, :submitter_comments, :notes
  has_one :user
  has_one :target
end
