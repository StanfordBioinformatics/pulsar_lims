class SequencingRunSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
             :comment,
             :lane,
             :name,
             :notes,
             :created_at,
             :updated_at

  has_one :report
  has_one :sequencing_request
  has_one :storage_location
  has_one :user
end
