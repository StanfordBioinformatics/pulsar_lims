class SequencingPlatformSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
        :name,
        :notes,
        :upstream_identifier,
        :created_at,
        :updated_at

  has_one :user
  
end
